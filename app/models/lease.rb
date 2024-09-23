# frozen_string_literal: true

# class for managing rented out commodities
class Lease < ApplicationRecord
  belongs_to :listing
  belongs_to :renter_bid

  def self.lender_rented_commodities(lender_id)
    lender_listings_ids = Listing.where(lender_id: lender_id).pluck(:id)
    leases_listing_ids = Lease.where(listing_id: lender_listings_ids).pluck(:listing_id)

    commodities = []
    Listing.where(id: leases_listing_ids).each do |listing|
      commodities << { commodity_id: listing.commodity_id, created_at: listing.created_at,
                       quote_price_per_month: listing.price_per_month,
                       item_category: listing.commodity.category.name, status: 'rented',
                       accepted_bid_price: listing.lease.bid_price_per_month,
                       accepted_rented_period: listing.lease.lease_period_in_month }
    end

    commodities
  end
end
