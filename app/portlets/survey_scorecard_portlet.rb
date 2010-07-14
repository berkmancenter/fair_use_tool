class SurveyScorecardPortlet < Portlet

  # Mark this as 'true' to allow the portlet's template to be editable via the CMS admin UI.
  enable_template_editor false
     
  #-------------------------------------------------------
  # SurveyScorecardPortlet:
  # This shows the results for any "scorecard," which is 
  # just a tricky way of displaying the results of an 
  # official survey. It would seem that at some point,
  # they may want to show the results of various cases
  # in arbitrary ways; this does that.
  #-------------------------------------------------------
  
  def render
    @case = Case.find(self.case_id)
    @survey = Survey.find(self.survey_id)
    @results = CaseAnswer.find(:all, :conditions => {:case_id => self.case_id, :survey_id => self.survey_id})
    @judgement, @tie_broken = judgement(@results)
    @red_green_values = red_green_totals(@results)
  end
    
end