class IndependentSurveyPortlet < Portlet

  # Mark this as 'true' to allow the portlet's template to be editable via the CMS admin UI.
  enable_template_editor false
  
  #-------------------------------------------------------
  # IndependentSurveyPortlet:
  # A survey can be taken on its own, or with a specific 
  # case being referenced. This portlet shows the form for 
  # an independent survey, which is actually identical to 
  # a regular survey. It is only broken up into a portlet 
  # so that CMS admins can mess with it if they need to.
  #-------------------------------------------------------
     
  def render
    @survey = Survey.find(self.survey_id)
  end
    
end