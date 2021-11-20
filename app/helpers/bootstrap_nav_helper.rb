module BootstrapNavHelper
  def navbar_link_to(nav_text, nav_path, link_options = {})
    is_active = current_page?(nav_path)
    link_options[:class] = "#{link_options[:class]} nav-link"
    content_tag :li, class: "nav-item #{"active" if is_active}" do
      link_to nav_text, nav_path, **link_options
    end
  end

  def nav_link_to(nav_text, nav_path, link_options = {})
    is_active = current_page?(nav_path)
    link_options[:class] = "#{link_options[:class]} nav-link #{"active" if is_active}"
    content_tag :li, class: "nav-item" do
      link_to nav_text, nav_path, **link_options
    end
  end
end
