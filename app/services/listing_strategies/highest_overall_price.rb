# frozen_string_literal: true

module ListingStrategies
  # class for calculation highest overall price
  class HighestOverallPrice
    def execute(params)
      listing = Listing.find_by(id: params[:listing_id])
      return unless listing.present?

      all_bids = RenterBid.where(listing_id: params[:listing_id])
      max_bid_amount_hash = { renter_id: nil, amount: 0 }

      all_bids.each do |bid|
        total_rental_duration_cost = bid.price * bid.lease_period_in_month
        if total_rental_duration_cost > max_bid_amount_hash[:amount]
          max_bid_amount_hash = { renter_id: bid.renter_id, amount: total_rental_duration_cost }
        end
      end

      max_bid_amount_hash
    end
  end
end
