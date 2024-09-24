# frozen_string_literal: true

# Worker class to select renter bid
class BidSelectionWorker
  include Sidekiq::Worker
  sidekiq_options retry: 3

  def perform(params)
    params = params.with_indifferent_access
    listing = Listing.find_by(id: params[:listing_id])
    return unless listing.present?

    strategy_response = ListingStrategies::Manager.new.call(listing.strategy, params)
    unless strategy_response[:renter_id].present?
      listing.update!(active: false)
      return
    end

    renter_bid = RenterBid.where(renter_id: strategy_response[:renter_id]).last

    Lease.create!(listing_id: renter_bid.listing_id, renter_bid_id: renter_bid.id, active: true)
  end
end
