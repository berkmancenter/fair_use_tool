class IndexPortlet < Portlet

  # Mark this as 'true' to allow the portlet's template to be editable via the CMS admin UI.
  enable_template_editor false

  
  #-------------------------------------------------------
  # IndexPortlet:
  # Just a container portlet so that the admins have 
  # control of the placement of the data that will go on 
  # root ("/") page of site. Will likely be a relatively 
  # straightforward, static page, but may need much more 
  # tweaking depending on what they have you do.
  #-------------------------------------------------------
  
  def render
    # Your Code Goes Here
  end
    
end