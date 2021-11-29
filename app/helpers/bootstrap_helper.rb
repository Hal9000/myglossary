# Modified from the Twitter Bootstrap Rails gem's Bootstrap Flash Helper (bootstrap 3) for Bootstrap 4
# Place in the helpers folder
module BootstrapHelper
  # Use "bootstrap_flash_help" instead of "bootstrap_flash"
  ALERT_TYPES = [
    :primary,
    :secondary,
    :success,
    :danger,
    :warning,
    :info,
    :light,
    :dark,
  ] unless const_defined?(:ALERT_TYPES)

  def bootstrap_flash_help(options = {})
    flash_messages = []
    flash.each do |type, message|
      # Skip empty messages, e.g. for devise messages set to nothing in a locale file.
      next if message.blank?

      type = type.to_sym
      type = :success if type == :notice
      type = :danger  if type == :alert
      type = :danger  if type == :error
      next unless ALERT_TYPES.include?(type)

      tag_class = options.extract!(:class)[:class]
      tag_options = {
        class: "alert alert-#{type} #{tag_class} alert-dismissible show",
        role: "alert"
      }.merge(options)

      close_button = content_tag(:button, "", type: "button", class: "btn-close", "data-bs-dismiss" => "alert")

      Array(message).each do |msg|
        text = content_tag(:div, sanitize(msg + close_button.html_safe), tag_options)
        flash_messages << text if msg
      end
    end
    flash_messages.join("\n").html_safe
  end
end