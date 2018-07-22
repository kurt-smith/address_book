# frozen_string_literal: true

module CompaniesHouse
  module Officer
    def self.transform(payload)
      name = payload['name'].split(',')

      {
        first_name: name.last.strip.titleize,
        last_name: name.count.eql?(1) ? nil : name.first.strip.titleize,
        occupation: payload['occupation'].presence || payload['officer_role'].presence&.titleize,
        corporation: payload['officer_role'].include?('corporate'),
        residence: payload['country_of_residence'],
        appointed_on: payload['appointed_on'],
        address: CompaniesHouse::Address.transform(payload['address'])
      }
    end
  end
end
