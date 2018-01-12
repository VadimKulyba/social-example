# main helper
module ApplicationHelper
  # return full title for page
  def full_title(page_title)
    base_title = 'Ruby on Rails App'
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
end
