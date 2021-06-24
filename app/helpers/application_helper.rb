module ApplicationHelper
  def display_photo(user)
    if user.photo.attached?
      user.photo.key
    else
      "msrq1gzrlfh0qpuwjgoc.png"
    end
  end

  def highlight_home
    request.path == root_path ? 'active' : ''
  end

  def highlight_tab(tab)
    request.path.include?(tab) ? 'active' : ''
  end

  def show_notice
    'hide' if current_user.nil? || current_user.tags.length.nonzero?
  end
end
