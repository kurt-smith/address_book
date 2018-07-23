# frozen_string_literal: true

module Contact
  class InvalidType < StandardError; end

  class Base
    include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Paranoia

    store_in collection: 'contacts'

    # fields
    field :type, type: String

    # validations
    validates :type, presence: { message: 'is required' },
                     inclusion: { in: Contact::Type::ALL, message: 'must be valid app type' }

    # callbacks
    after_initialize :set_type

    def self.by_type(type)
      case type
      when /company/ then Contact::Company
      when /officer/ then Contact::Officer
      else raise Contact::InvalidType.new(message: 'Invalid contact type', type: type)
      end
    end

    private

    # sets the type of the contact
    # set to nil so you can't create a base type
    def set_type
      write_attribute(:type, nil)
    end
  end
end
