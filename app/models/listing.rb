# frozen_string_literal: true

# class for managing listings of users as lenders
class Listing < ApplicationRecord
  belongs_to :lender, class_name: 'User', foreign_key: 'lender_id'
  belongs_to :commodity

  def self.lender_listed_commodities(lender_id)
    commodities = []
    Listing.where(lender_id: lender_id).each do |listing|
      commodities << { commodity_id: listing.commodity_id, created_at: listing.created_at,
                       quote_price_per_month: listing.price_per_month,
                       item_category: listing.commodity.category.name, status: 'listed',
                       accepted_bid_price: nil,
                       accepted_rented_period: nil }
    end

    commodities
  end
end
