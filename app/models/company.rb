# frozen_string_literal: true

class Company
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  store_in collection: 'companies'

  embeds_one :address, autobuild: true
  has_many :officers, dependent: :destroy

  field :name, type: String
  field :number, type: String
  field :active, type: Boolean, default: false
  field :description, type: String, default: nil

  validates :name, presence:   { message: 'is required' },
                   length:     { minimum: 1, maximum: 255,
                                 message: 'must have more than 1 and less than 255 characters' }

  validates :number, presence: { message: 'is required' },
                     uniqueness: { conditions: -> { where(deleted_at: nil) } },
                     length:     { minimum: 1, maximum: 255,
                                   message: 'must have more than 1 and less than 255 characters' }

  # indexes
  index({ number: 1, deleted_at: 1 }, unique: true, name: 'unique_number_index')
end
