Rails.application.routes.draw do
  devise_for :users
  root "static_pages#home"
  get "inspections",         to: "inspections#all",          as: "all_inspections"
  get "inspections/new",     to: "inspections#select_site",  as: "new_inspection"
  get "business_trips",      to: "business_trips#all",       as: "all_business_trips"
  get "business_trips/new",  to: "business_trips#select_site", as: "new_business_trip"
  resources :sites do
    resources :inspections
    resources :business_trips
  end
end