# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def tlize(text)
    text = RedCloth.new(text)
    return text.to_html
  end
end
