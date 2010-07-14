class CaseResourcePortlet < Portlet

  # Mark this as 'true' to allow the portlet's template to be editable via the CMS admin UI.
  enable_template_editor false
  
  #-------------------------------------------------------
  # CaseResourcePortlet:
  # Renders the image specified for the given case. Each
  # case has an original_resource and derivative_resource,
  # where the original resource is the copied piece, and
  # the derivative is the thing that potentially infringes
  # the copyright. Specify either "original" or 
  # "derivative" and the specific case, get that image.
  # Project was built with scaling to any type of media
  # (Video,music,etc...), but this has not been fully 
  # implemented.
  #-------------------------------------------------------
  
     
  def render
    @original = self.original?
    @case = Case.find(self.case_id)
  end
  
  def original?
    return self.resource_type == "original"
  end
    
end