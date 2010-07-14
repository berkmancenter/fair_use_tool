class UserAnswersController < ApplicationController

  before_filter :get_survey
  
  # @survey is used in each one, so it might as well get picked up. 
  # If it isn't explicitly accessed in controller's action, it is in the view.
  def get_survey
    if params[:survey_id]
      @survey = Survey.find(params[:survey_id])
    elsif params[:case_id]
      @survey = Survey.find(Case.find(params[:case_id]).survey_id)
    end
  end

  # This is SUPER complicated to read, I'll go through slowlike
  def create
    # Instantiate the case,session_id, and delete any old answers for this case/survey/session combo.
    @case = params[:case_id].nil? ? nil : Case.find(params[:case_id])
    session_id = params[:session_id].to_s
    clear_prior_responses(session_id, @case, @survey)
    errors = []
    # If we did in fact get answers from the survey
    if params[:answer]
      # collect and save them as new UserAnswers, then check against each for "valid?" errors
      # and against .save errors.
      @results = params[:answer].values.collect { |answer| UserAnswer.new(:session_id => session_id,
                                                                          :answer_id => answer,
                                                                          :survey_id => @survey.id,
                                                                          :case_id => @case.nil? ? nil : @case.id)}
      errors << "Please answer all questions." unless @results.size == @survey.questions.with_answers.length
      @results.all? {|answer| errors << answer.errors unless answer.valid? } if errors.empty?
      @results.each {|answer| errors << answer.errors unless answer.save } if errors.empty?
    else
      # There are no answers, so make them do it again
      errors << "Please answer all questions."
    end
   respond_to do |format|
      if errors.empty?
        flash[:notice] = 'Answer was successfully created.'
        format.html { 
          if params[:case_id]
            # If there is a case id, then this came from a case page. 
            # We can send them the results alongside that case.
            redirect_to(:action => "case_results", :case_id => @case.id, :session_id => session_id)
          else
            # We don't know about any specific case, so we just show them their results.
            redirect_to(:action => "survey_results", :survey_id => @survey.id, :session_id => session_id)
          end
        }
        format.xml  { render :xml => @results, :status => :created, :location => @results }
      else
        # Redirect to the referrer, display the errors.
        flash[:error] = errors.join("/n")
        format.html { redirect_to(request.referrer)}
        format.xml  { render :xml => @results.errors, :status => :unprocessable_entity }
      end
    end
  end

  def clear_prior_responses(session_id, kase, survey)
    # Look in the database for old versions of this data, delete them. Easier than doing updates. 
    # Also, since BrowserCMS actually just toggles an additional field called .deleted (true|false) to true when you "destroy!"
    # (Because BrowserCMS overrides most of the CRUD functions like this to modify/control for versions and other neat stuff)
    # This is actually more reliable, as we keep the data, but we no longer think about as "live" data.
    UserAnswer.find(:all, :conditions => {:session_id => session_id.nil? ? nil : session_id, :case_id => kase.nil? ? nil : kase.id, :survey_id => survey.nil? ? nil : survey.id}).collect{|ua| ua.destroy! }
  end
  
  def survey_results
    # Grab the results for the passed parameters - basically, we want the combo of that survey and that session_id.
    # Since the previous data is now "deleted" (because its actually still there, see above comments), 
    # this will grab the entire set we're interested in. Setting case_id to something other than 
    # nil would return this user's case answers across site as well.
    @results = UserAnswer.find(:all, :conditions => {:session_id => params[:session_id], :survey_id => params[:survey_id], :case_id => nil}).sort_by{|x| x.answer.question.order}
    render :layout => "main"
  end
  
  def case_results
    # Return the combo of results for this case. Also, since were going to show a case alongside, 
    # make an inst_var called @official_results for passing into scorecard partial to show the official results alongside the "@results."
    @case = Case.find(params[:case_id])
    @survey = @case.survey
    @results = UserAnswer.find(:all, :conditions => {:session_id => params[:session_id], :survey_id => @survey.id, :case_id => @case.id}).sort_by{|x| x.answer.question.order}
    @official_results = @case.case_answers.sort_by{|x| x.answer.question.order}
    render :layout => "main"
  end
end
