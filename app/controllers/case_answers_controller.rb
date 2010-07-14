class CaseAnswersController < ApplicationController

  def create
    #Similar comments here as with the UserAnswer Controller - read that one for explanation
    @case = Case.find(params[:case_id])
    @survey = Survey.find(params[:survey_id])
    @survey.verify_and_update(params, @case)
    errors = []
    if params[:answer]
    @answers = params[:answer].values.collect { |answer| CaseAnswer.new(:case_id => @case.id,
                                                                         :answer_id => answer,
                                                                         :updated_by_id => current_user.id,
                                                                         :created_by_id => current_user.id,
                                                                         :survey_id => @survey.id)}
    errors << "Please answer all questions." unless @answers.size == @survey.questions.with_answers.length
    @answers.all? {|answer| errors << answer.errors unless answer.valid? } if errors.empty?
    @answers.each {|answer| errors << answer.errors unless answer.save } if errors.empty?
    else
     errors << "Please answer all questions."
    end

    respond_to do |format|
     if errors.empty?
       flash[:notice] = 'Survey Successfully filled out.'
       format.html { redirect_to(:back) }
       format.xml  { render :xml => @answer, :status => :created, :location => @answer }
     else
       flash[:error] = errors.join("/n")
       format.html { redirect_to(new_survey_case_answer_path(@survey))}
       format.xml  { render :xml => @case_answer.errors, :status => :unprocessable_entity }
     end
    end
  end

end
