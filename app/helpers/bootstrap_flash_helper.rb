module BootstrapFlashHelper
  def translate_type(type)
    return :success if type == :notice
    return :danger  if type == :alert
    type
  end

  def build_tag(type, msg)
    content_tag :div, class: "alert alert-dismissable alert-#{type}" do
      button_tag(raw('&times;'), class: 'close', data: { dismiss: 'alert' }) +
        content_tag(:span, msg)
    end
  end

  def bootstrap_flash
    flash_messages = []

    flash.each do |type, message|
      type = translate_type(type.to_sym)
      flash_messages << build_tag(type, message)
    end

    flash_messages.join("\n").html_safe
  end
end
