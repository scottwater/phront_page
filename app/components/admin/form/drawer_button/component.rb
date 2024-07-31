# frozen_string_literal: true

class Admin::Form::DrawerButton::Component < Admin::AdminViewComponent
  option :position, default: proc { :right }
  option :drawer_id
  option :text, optional: true

  def drawer_settings
    {
      data: {
        controller: stimulus_controller,
        "drawer-target": "drawer-#{drawer_id}",
        "drawer-show": "drawer-#{drawer_id}",
        "drawer-placement": position,
        "#{stimulus_controller}-position-value": position,
        "#{stimulus_controller}-drawer-id-value": drawer_id
      },
      "aria-controls": "drawer-#{position}"
    }
  end
end
