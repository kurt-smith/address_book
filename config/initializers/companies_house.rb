# frozen_string_literal: true

require 'companies_house/client'

module CompaniesHouse
  Api ||= CompaniesHouse::Client.new(api_key: ENV.fetch('COMPANIES_HOUSE_API_KEY'))
end
