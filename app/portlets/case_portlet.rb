class CasePortlet < Portlet

  # Mark this as 'true' to allow the portlet's template to be editable via the CMS admin UI.
  enable_template_editor false
  
  #-------------------------------------------------------
  # CasePortlet:
  # Equivalent to the "show" action for a model using 
  # scaffold. In this project, it is used at /cases/:id
  #-------------------------------------------------------
  
     
  def render
    @case = Case.find(self.case_id)
  end
    
end