class UserAnswersPortlet < Portlet

  # Mark this as 'true' to allow the portlet's template to be editable via the CMS admin UI.
  enable_template_editor false
     
  #-------------------------------------------------------
  # UserAnswersPortlet:
  # A poorly-named portlet, but it is responsible for
  # collecting the survey results from some person using
  # the site. Essentially, it just renders the 
  # /surveys/survey partial, then pushes off to the 
  # case_results action in the UserAnswers controller,
  # which in turn shows the page of results alongside the 
  # official CaseAnswer results.
  #-------------------------------------------------------
  
  
  def render
    @case = Case.find(self.case_id)
    @survey = @case.survey
  end
    
end