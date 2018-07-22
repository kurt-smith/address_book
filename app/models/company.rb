# frozen_string_literal: true

class Company
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  store_in collection: 'companies'

  embeds_one :address, autobuild: true
  has_many :officers, dependent: :destroy

  field :name, type: String
  field :number, type: Integer
  field :active, type: Boolean, default: false
  field :description, type: String, default: nil

  validates :name, presence:   { message: 'is required' },
                   length:     { minimum: 1, maximum: 255,
                                 message: 'must have more than 1 and less than 255 characters' }

  validates :number, presence: { message: 'is required' },
                     numericality: { only_integer: true }

  before_validation :standardize_fields

  private

  def standardize_fields
    self.number = number.presence&.to_i
  end
end
