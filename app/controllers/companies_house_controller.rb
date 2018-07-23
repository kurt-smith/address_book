# frozen_string_literal: true

class CompaniesHouseController < ApplicationController
  before_action :company_id, only: %i[show]

  ITEMS_PER_PAGE = 100

  def home; end

  def show
    @company = Rails.cache.fetch("company_#{company_id}", expires_in: 12.hours) do
      resp = CompaniesHouse::Api.company(company_id)
      CompaniesHouse::Company.transform(resp)
    end

    @officers = Rails.cache.fetch("officers_company_#{company_id}", expires_in: 12.hours) do
      resp = CompaniesHouse::Api.officers(company_id)
      resp.map { |x| CompaniesHouse::Officer.transform(x) }
    end

    respond_to :js
  end

  def company_search
    @companies = Rails.cache.fetch("company_search_#{company_search_params[:name]}", expires_in: 12.hours) do
      resp = CompaniesHouse::Api.company_search(company_search_params[:name], items_per_page: ITEMS_PER_PAGE)
      resp['items'].map { |x| CompaniesHouse::Company.transform(x) }
    end

    respond_to :js
  end

  private

  def company_search_params
    params.require(:company).permit(:name)
  end

  def company_params
    params.require(:company).permit(:name, :number, :officer_number)
  end

  def company_id
    @company_id ||= params[:company_id]
  end
end
