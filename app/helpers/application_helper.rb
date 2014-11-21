module ApplicationHelper
   def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-error", alert: "alert-warning", notice: "alert-info" }[flash_type] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do
              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
              concat message
            end)
    end
    nil
  end

  def include_javascript (file)
    s = " <script type=\"text/javascript\">" + render(:file => file) + "</script>"
    content_for(:head, raw(s))
end

  def format_survey_label(label_text)
    label_text
  end

  def present(object, klass = nil)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)
    yield presenter if block_given?
    presenter
  end

  def present_survey(survey_form, survey_data)
    presenter = SurveyPresenter.new(survey_form, survey_data, self)
    yield presenter if block_given?
    presenter
  end
end

