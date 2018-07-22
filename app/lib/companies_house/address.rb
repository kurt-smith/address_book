# frozen_string_literal: true

module CompaniesHouse
  module Address
    def self.transform(payload)
      {
        address_line_1: payload['address_line_1']&.strip,
        address_line_2: payload['address_line_2']&.strip,
        country: payload['country']&.strip,
        region: payload['region']&.strip,
        locality: payload['locality']&.strip,
        premises: payload['premises']&.strip,
        postal_code: payload['postal_code']&.strip
      }
    end
  end
end
