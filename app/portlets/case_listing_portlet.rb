class CaseListingPortlet < Portlet

  # Mark this as 'true' to allow the portlet's template to be editable via the CMS admin UI.
  enable_template_editor false
     
  #-------------------------------------------------------
  # CaseListingPortlet:
  # Renders a small list-element view of the case; in a
  # regular rails app, it is analogous to the index 
  # controller's items listed in tables (with scaffold).
  # Used on /cases.
  #-------------------------------------------------------

  def render
    @case = Case.find(self.case_id)
    @page_path = Page.find(self.page_id).path
  end
    
end