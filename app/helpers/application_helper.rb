module ApplicationHelper
  
  def logo
    image_tag("logo.png", :alt => "Application exemple", :class => "round")
  end
end
