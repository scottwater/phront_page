# frozen_string_literal: true

class Admin::Logo::Component < Admin::AdminViewComponent
  # NOTE
  # `#controller` can't be used during initialization, as it depends on the view context that only exists once a ViewComponent is passed to the Rails render pipeline.
  # This is why there is the logo url helper method and not a default value
  option :url, optional: true

  def logo_url
    url || admin_root_path
  end
end
