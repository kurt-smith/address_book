# frozen_string_literal: true

class Officer
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  store_in collection: 'officers'

  embeds_one :address, autobuild: true
  belongs_to :company

  field :first_name, type: String
  field :last_name, type: String
  field :occupation, type: String
  field :corporation, type: Boolean, default: false
  field :residence, type: String, default: nil
  field :appointed_on, type: Date, default: nil

  validates :first_name, presence:   { message: 'is required' },
                         length:     { minimum: 1, maximum: 255,
                                       message: 'must have more than 1 and less than 255 characters' }

  validates :last_name, allow_blank: true,
                        presence:   { message: 'is required' },
                        length:     { minimum: 1, maximum: 255,
                                      message: 'must have more than 1 and less than 255 characters' }

  validates :occupation, allow_blank: true,
                         presence:   { message: 'is required' },
                         length:     { minimum: 1, maximum: 255,
                                       message: 'must have more than 1 and less than 255 characters' }

  before_validation :standardize_fields

  def name
    "#{last_name}, #{first_name}"
  end

  private

  def standardize_fields
    self.first_name = first_name&.titleize
    self.last_name = last_name&.titleize
    self.occupation = occupation&.titleize
    self.residence = residence.presence&.titleize
    self.appointed_on = appointed_on.presence&.to_date
  end
end
