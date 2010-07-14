class CaseDirectionsPortlet < Portlet

  # Mark this as 'true' to allow the portlet's template to be editable via the CMS admin UI.
  enable_template_editor false
     
  #-------------------------------------------------------
  # CaseDirectionsPortlet:
  # Gives the Directions for surveying/engaging a case 
  # page and, as of the comps in Summer 2010, is required 
  # as helpful copy on case pages
  #-------------------------------------------------------
  def render
    @case = Case.find(self.case_id)
  end
    
end