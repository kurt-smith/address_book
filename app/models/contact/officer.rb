# frozen_string_literal: true

module Contact
  class Officer < Contact::Base
    # associations
    belongs_to :officer, class_name: 'Officer'

    private

    # sets the type of the contact
    def set_type
      write_attribute(:type, Contact::Type::OFFICER)
    end
  end
end
