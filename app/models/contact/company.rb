# frozen_string_literal: true

module Contact
  class Company < Contact::Base
    # associations
    belongs_to :company, class_name: 'Company'

    private

    # sets the type of the contact
    def set_type
      write_attribute(:type, Contact::Type::COMPANY)
    end
  end
end
