module ApplicationHelper
  def admin?
    current_user == 0
  end
end
