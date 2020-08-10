module SessionsHelper
  def flash_message(type)
    if flash[type]
      content_tag :p, flash[type], class: "flash #{type}"
    end
  end
end
