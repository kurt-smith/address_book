# frozen_string_literal: true

require 'rails_helper'

describe Officer, models: true do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to be_stored_in(collection: 'officers') }
  it { is_expected.to have_field(:company_id).of_type(Object) }
  it { is_expected.to have_field(:first_name).of_type(String) }
  it { is_expected.to have_field(:last_name).of_type(String) }
  it { is_expected.to have_field(:occupation).of_type(String) }
  it { is_expected.to have_field(:corporation).of_type(Mongoid::Boolean) }
  it { is_expected.to have_field(:residence).of_type(String).with_default_value_of(nil) }
  it { is_expected.to have_field(:appointed_on).of_type(Date).with_default_value_of(nil) }
  it { is_expected.to have_timestamps }
  it { is_expected.to have_field(:deleted_at).of_type(Time).with_default_value_of(nil) }

  it { is_expected.to belong_to(:company).of_type(Company) }
  it { is_expected.to embed_one(:address) }

  context 'validations' do
    %i[first_name last_name occupation].each do |field|
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

  describe '#standardize_fields' do
    let(:officer) do
      FactoryBot.build(:officer, first_name: Faker::Name.first_name.downcase,
                                 last_name: Faker::Name.last_name.downcase,
                                 occupation: Faker::Job.title.downcase)
    end

    %w[first_name last_name occupation].each do |field|
      it "titleizes #{field} field" do
        expect(officer[field.to_sym]).to eq(officer[field.to_sym].downcase)
        officer.valid?
        expect(officer[field.to_sym]).to eq(officer[field.to_sym].titleize)
      end
    end

    context 'residence' do
      it do
        expect(officer.residence).to eq(nil)
        officer.valid?
        expect(officer.residence).to eq(nil)
      end

      it do
        officer.residence = 'uk'
        expect(officer.residence).to eq('uk')
        officer.valid?
        expect(officer.residence).to eq('Uk')
      end
    end

    context 'appointed_on' do
      it do
        expect(officer.appointed_on).to eq(nil)
        officer.valid?
        expect(officer.appointed_on).to eq(nil)
      end

      it do
        officer.appointed_on = '2017-08-21'
        expect(officer.appointed_on).to eq(Date.new(2017, 8, 21))
      end
    end
  end
end
