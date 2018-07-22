# frozen_string_literal: true

module CompaniesHouse
  module Company
    def self.transform(payload)
      {
        name: payload['title']&.titleize&.strip || payload['company_name']&.titleize&.strip || payload['name']&.titleize&.strip,
        number: payload['company_number'].strip,
        active: payload['company_status'].eql?('active'),
        description: payload['description']&.strip,
        full_address: payload['address_snippet']&.strip,
        address: CompaniesHouse::Address.transform(payload['address'] || payload['registered_office_address'])
      }
    end
  end
end
