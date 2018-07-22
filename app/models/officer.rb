# frozen_string_literal: true

class Officer
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  store_in collection: 'officers'

  belongs_to :company

  field :first_name, type: String
  field :last_name, type: String
  field :occupation, type: String
  field :residence, type: String, default: nil
  field :appointed_on, type: Date, default: nil

  validates :first_name, presence:   { message: 'is required' },
                         length:     { minimum: 1, maximum: 255,
                                       message: 'must have more than 1 and less than 255 characters' }

  validates :last_name, presence:   { message: 'is required' },
                        length:     { minimum: 1, maximum: 255,
                                      message: 'must have more than 1 and less than 255 characters' }

  validates :occupation, presence:   { message: 'is required' },
                         length:     { minimum: 1, maximum: 255,
                                       message: 'must have more than 1 and less than 255 characters' }

  before_validation :standardize_fields

  private

  def standardize_fields
    self.first_name = first_name&.titleize
    self.last_name = last_name&.titleize
    self.occupation = occupation&.titleize
    self.residence = residence.presence&.titleize
    self.appointed_on = appointed_on.presence&.to_date
  end
end
