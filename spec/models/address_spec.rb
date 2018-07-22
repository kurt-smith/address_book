# frozen_string_literal: true

require 'rails_helper'

describe Address, models: true do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to be_stored_in(collection: 'adresseses') }
  it { is_expected.to have_field(:address_line_1).of_type(String) }
  it { is_expected.to have_field(:address_line_2).of_type(String).with_default_value_of(nil) }
  it { is_expected.to have_field(:country).of_type(String) }
  it { is_expected.to have_field(:region).of_type(String) }
  it { is_expected.to have_field(:locality).of_type(String) }
  it { is_expected.to have_field(:premises).of_type(String) }
  it { is_expected.to have_field(:postal_code).of_type(String) }

  it { is_expected.to have_timestamps }
  it { is_expected.to have_field(:deleted_at).of_type(Time).with_default_value_of(nil) }

  context 'validations' do
    %i[address_line_1 address_line_2 country region locality premises postal_code].each do |field|
      describe field.to_s do
        it { is_expected.to validate_presence_of(field).with_message('is required') }
        it do
          is_expected.to validate_length_of(field)
            .within(1..255)
            .with_message('must have more than 1 and less than 255 characters')
        end
      end
    end
  end
end
