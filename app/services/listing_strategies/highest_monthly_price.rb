# frozen_string_literal: true

module ListingStrategies
  # class for calculating highest monthly price
  class HighestMonthlyPrice
    def execute(params)
      listing = Listing.find_by(id: params[:listing_id])
      return unless listing.present?

      all_bids = RenterBid.where(listing_id: params[:listing_id])
      max_bid_amount_hash = { renter_id: nil, amount: 0 }

      all_bids.each do |bid|
        if bid.bid_price > max_bid_amount_hash[:amount]
          max_bid_amount_hash = { renter_id: bid.renter_id, amount: bid_price }
        end
      end

      max_bid_amount_hash
    end
  end
end
