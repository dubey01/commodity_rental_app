Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post 'login', to: 'sessions#create'

  post 'user/signup', to: 'users#create'
  post 'commodity/list', to: 'commodities#list_commodity'
  post 'commodity/bid', to: 'commodities#create_bid'
  post 'commodity/re-bid', to: 'commodities#update_bid'
  post 'commodity/re-list', to: 'commodities#re_list'

  get 'commodity/list', to: 'commodities#category_commodities'
  get 'commodity/:id/bids', to: 'commodities#fetch_commodity_bids'
  get 'commodity/my-commodities', to: 'commodities#lender_commodities'
end
