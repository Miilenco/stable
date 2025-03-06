module ApplicationHelper
  def render_info_window(horse)
    controller.render_to_string(partial: "horses/info_window", locals: { horse: horse })
  end
end
