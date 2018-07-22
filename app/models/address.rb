# frozen_string_literal: true

class Address
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  store_in collection: 'adresseses'

  field :address_line_1, type: String
  field :address_line_2, type: String, default: nil
  field :country, type: String
  field :region, type: String
  field :locality, type: String
  field :premises, type: String
  field :postal_code, type: String

  validates :address_line_1, presence:   { message: 'is required' },
                             length:     { minimum: 1, maximum: 255,
                                           message: 'must have more than 1 and less than 255 characters' }

  validates :address_line_2, allow_blank: true,
                             presence:   { message: 'is required' },
                             length:     { minimum: 1, maximum: 255,
                                           message: 'must have more than 1 and less than 255 characters' }

  validates :country, presence:   { message: 'is required' },
                      length:     { minimum: 1, maximum: 255,
                                    message: 'must have more than 1 and less than 255 characters' }

  validates :region, presence:   { message: 'is required' },
                     length:     { minimum: 1, maximum: 255,
                                   message: 'must have more than 1 and less than 255 characters' }

  validates :locality, presence:   { message: 'is required' },
                       length:     { minimum: 1, maximum: 255,
                                     message: 'must have more than 1 and less than 255 characters' }

  validates :premises, presence:   { message: 'is required' },
                       length:     { minimum: 1, maximum: 255,
                                     message: 'must have more than 1 and less than 255 characters' }

  validates :postal_code, presence:   { message: 'is required' },
                          length:     { minimum: 1, maximum: 255,
                                        message: 'must have more than 1 and less than 255 characters' }
end
