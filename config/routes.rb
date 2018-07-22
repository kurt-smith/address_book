# frozen_string_literal: true

Rails.application.routes.draw do
  root 'companies_house#home'

  get 'companies/search', to: 'companies_house#company_search', as: :company_search
  get 'companies/:company_id', to: 'companies_house#show', as: :company
end
