module PagesHelper
  
  # Retourne un titre basé sur la page
  def title
    title_base = "Simple App du Tutoriel Ruby on Rails"
    if @title.nil?
      title_base
    else
      "#{title_base} | #{@title}"
    end
  end
  
end
