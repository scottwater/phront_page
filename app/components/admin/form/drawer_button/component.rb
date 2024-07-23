# frozen_string_literal: true

class Admin::Form::DrawerButton::Component < Admin::AdminViewComponent
  option :position, default: proc { :right }
  option :text, optional: true

  def drawer_settings
    {
      data: {
        controller: stimulus_controller,
        "drawer-target": "drawer-#{position}",
        "drawer-show": "drawer-#{position}",
        "drawer-placement": position,
        "#{stimulus_controller}-position-value": position
      },
      "aria-controls": "drawer-#{position}"
    }
  end
end
