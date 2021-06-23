module ApplicationHelper
  def display_photo(user)
    if user.photo.attached?
      user.photo.key
    else
      "msrq1gzrlfh0qpuwjgoc.png"
    end
  end

  def current_class?(test_path)
    request.path == test_path ? 'active' : ''
  end
end
