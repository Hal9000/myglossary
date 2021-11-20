module ApplicationHelper
  def admin?
    current_user.admin? || current_user == 1
  end
end
