class QuestionExplanationPortlet < Portlet

  # Mark this as 'true' to allow the portlet's template to be editable via the CMS admin UI.
  enable_template_editor false
  
  #-------------------------------------------------------
  # QuestionExplanationPortlet:
  # This portlet creates the named links on a page for 
  # explaining the question passed in 
  # (question.explanation). In current iteration, it 
  # is used in /surveys_explanation/:survey_id pages to
  # show up in pop-up from any case page utilizing that 
  # survey.
  #-------------------------------------------------------
     
  def render
    @question = Question.find(self.question_id)
  end
    
end