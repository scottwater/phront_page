# frozen_string_literal: true

module TimeZones
  IANA_TO_RAILS_MAPPING = ActiveSupport::TimeZone::MAPPING.invert

  def self.browser_time_zone_to_rails(browser_time_zone)
    rails_time_zone = IANA_TO_RAILS_MAPPING[browser_time_zone]

    if rails_time_zone.nil?
      # If there's no exact match, find the closest match
      offset = ActiveSupport::TimeZone[browser_time_zone]&.utc_offset
      rails_time_zone = ActiveSupport::TimeZone.all.find { |zone| zone.utc_offset == offset }&.name
    end

    rails_time_zone || "UTC" # Default to UTC if no match is found
  end
end
