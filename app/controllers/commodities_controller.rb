class CommoditiesController < ApplicationController
  def create
    new_commodity = Commodity.new(commodity_params)
    if new_commodity.save!
      render json: { status: 'success', message: 'commodity created successfully',
                     payload: { commodity_id: new_commodity.reload.id } }, status: :ok
    end
  rescue StandardError => e
    render json: { status: 'error', message: 'commodity cannot be created', payload: { error: e } },
           status: :unprocessable_entity
  end

  # post /commodity/list
  def list_commodity
    new_commodity = Commodity.new(commodity_params)
    if new_commodity.save!
      render json: { status: 'success', message: 'commodity listed successfully',
                     payload: { commodity_id: new_commodity.reload.id,
                                quote_price_per_month: new_commodity.price_per_month,
                                created_at: new_commodity.created_at } }, status: :ok
    end
  rescue StandardError => e
    render json: { status: 'error', message: 'commodity could not be listed', payload: { error: e } },
           status: :unprocessable_entity
  end

  # get commodity/list
  def category_commodities
    commodities = Commodity.joins(:listing).where(category_id: commodity_params[:category_id]).select('commodities.id,
                                                                                                       listings.created_at, 
                                                                                                       listings.price_per_month, 
                                                                                                       commodities.category_id')
    resp = []
    commodities.each do |commodity|
      resp << { commodity_id: commodity.id, created_at: commoldity.created_at,
                quote_price_per_month: commodity.price_per_month, item_category: commodity.category_id }
    end

    render json: { status: 'success', message: 'available commodities fetched successfully', payload: resp },
           status: :ok
  rescue StandardError => e
    render json: { status: 'error', payload: { error: e } }, status: :unprocessable_entity
  end

  def listed_commodities
  end

  # post commodity/bid
  def create_bid
    new_bid = RenterBid.new(bid_params)
    if new_bid.save!
      render json: { status: 'success', message: 'bid created successfully', payload: { bid_id: new_bid.reload.id,
                                                                                        commodity_id: new_bid.listing.commodity_id,
                                                                                        created_at: new_bid.created_at } },
             status: :ok
    end
  rescue StandardError => e
    render json: { status: 'error', payload: { error: e } }
  end

  # post commodity/re-bid
  def update_bid
    bid = RenterBid.find(bid_params[:id])
    bid.update!(bid_params)
    render json: { status: 'success', message: 'bid revised successfully', payload: { bid_id: new_bid.reload.id,
                                                                                      commodity_id: new_bid.listing.commodity_id,
                                                                                      bid_price_per_month: new_bid.price_per_month,
                                                                                      rental_duration: new_bid.lease_period_in_month,
                                                                                      created_at: new_bid.created_at } },
           status: :ok
  rescue StandardError => e
    render json: { status: 'error', payload: { error: e } }, status: :unprocessable_entity
  end

  # get commodity/id/bids
  def fetch_commodity_bids
    listing_bids = RenterBid.where(listing_id: listing_params[:id])
    if listing_bids.present?
      resp = []
      listing_bids.each do |bid|
        resp << { bid_id: bid.id, created_at: bid.created_at, bid_price_per_month: bid.bid_price_per_month,
                  rental_duration: bid.lease_period_in_month }
      end
      render json: { status: 'success', message: 'bids for commodity fetched successfully', payload: resp }, status: :ok
    else
      render json: { status: 'success', message: 'no bids yet', payload: listing_bids }, status: :ok
    end
  rescue StandardError => e
    render json: { status: 'error', payload: { error: e } }, status: :unprocessable_entity
  end

  # post commodity/re-list
  def re_list
    listing = Listing.find(listing_params[:id])
    listing.update!(listing_params)

    render json: { status: 'success', message: 'commodity re-listed successfully', payload: { commodity_id: listing.commodity_id, 
                                                                                              quote_price_per_month: listing.price_per_month,
                                                                                              created_at: listing.created_at, 
                                                                                              updated_at: listing.updated_at } }
  rescue StandardError => e
    render json: { status: 'error', payload: { error: e } }, status: :unprocessable_entity
  end

  # get commodity/my-commodities
  def lender_commodities
    resp = Commodity.lender_listed_commodities(lender_id) + Lease.lender_rented_commodities(lender_id)

    render json: { status: 'success', message: 'commodities fetched successfully', payload: resp }, status: :ok
  rescue StandardError => e
    render json: { status: 'error', payload: { error: e } }, status: :unprocessable_entity
  end

  private

  def commodity_params
    params.require(:commodity).permit(:name, :make, :description, :category_id, :price_per_month, :strategy)
  end

  def bid_params
    params.require(:bid).permit(:id, :listing_id, :bid_price, :lease_period_in_month)
  end

  def listing_params
    params.require(:listing).permit(:id, :price_per_month, :strategy)
  end
end
