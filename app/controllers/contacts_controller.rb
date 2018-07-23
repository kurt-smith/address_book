# frozen_string_literal: true

class ContactsController < ApplicationController
  def new
    @contact = Contact::Base.new
  end

  # Assumptions:
  #  1. A company can already exist
  #  2. An officer has to be associated with a company
  def create
    @company = Company.find_or_initialize_by(number: contact_params[:company][:number])
    @company.name = contact_params[:company][:name]
    @company_contact = Contact::Company.find_or_initialize_by(company_id: @company[:id])

    if contact_params[:company][:company_only].eql?('true')
      return redirect_to(contacts_path) if @company.save && @company_contact.save
    else
      @officer = Officer.new(contact_params[:officer])
      @officer.company = @company
      @officer_contact = Contact::Officer.find_or_initialize_by(officer: @officer)

      return redirect_to(contacts_path) if @company.save && @company_contact.save && @officer.save && @officer_contact.save
    end

    render :new
  end

  # return list of contacts
  def index
    @companies = Contact::Company.all.map do |x|
      {
        company: x.company[:name],
        name: x.company[:number],
        address: x.company.address.display_name
      }
    end.compact

    @officers = Contact::Officer.all.map do |x|
      # logger.info(contact_officer: x.officer, company: x.officer.company.name,
      #             name: x.officer.name,
      #             address: x.officer.address.display_name)

      {
        company: x.officer.company.name,
        name: x.officer.name,
        address: x.officer.address.display_name
      }
    end.compact

    @contacts = @companies.push(*@officers)
    @contacts.sort_by! { |k| k[:company] }
  end

  # Import company info and officers
  def import
    @company = Company.find_or_initialize_by(number: contact_params[:company][:number])
    @company.assign_attributes(contact_params[:company])
    @company_contact = Contact::Company.find_or_initialize_by(company: @company)

    @officer_contacts = []
    @officers = []

    contact_params[:officer].each do |officer|
      o = @company.officers.new(officer)
      @officers << o
      @officer_contacts << Contact::Officer.new(officer: o)
    end

    @company.save && @company_contact.save && @officers.each(&:save) && @officer_contacts.each(&:save)

    logger.error(company: @company.errors, company_contact: @company_contact.errors, officers: @officers.map(&:errors), officer_contacts: @officer_contacts.map(&:errors))

    respond_to :js
  end

  private

  def contact_params
    # @note this is bad, but bypassing due to time constraints
    params.permit!
  end
end
