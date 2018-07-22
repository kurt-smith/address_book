# frozen_string_literal: true

require 'rails_helper'

describe Company, models: true do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to be_stored_in(collection: 'companies') }
  it { is_expected.to have_field(:name).of_type(String) }
  it { is_expected.to have_field(:number).of_type(String) }
  it { is_expected.to have_field(:active).of_type(Mongoid::Boolean).with_default_value_of(false) }
  it { is_expected.to have_field(:description).of_type(String).with_default_value_of(nil) }
  it { is_expected.to have_timestamps }
  it { is_expected.to have_field(:deleted_at).of_type(Time).with_default_value_of(nil) }

  it { is_expected.to have_many(:officers).of_type(Officer).with_dependent(:destroy) }
  it { is_expected.to embed_one(:address) }

  context 'validations' do
    describe 'name' do
      it { is_expected.to validate_presence_of(:name).with_message('is required') }
      it do
        is_expected.to validate_length_of(:name)
          .within(1..255)
          .with_message('must have more than 1 and less than 255 characters')
      end
    end

    describe 'number' do
      it { is_expected.to validate_presence_of(:number).with_message('is required') }
      it do
        is_expected.to validate_length_of(:number)
          .within(1..255)
          .with_message('must have more than 1 and less than 255 characters')
      end
    end
  end
end
