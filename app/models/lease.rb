# frozen_string_literal: true

# class for managing rented out commodities
class Lease < ApplicationRecord
  belongs_to :listing
  belongs_to :renter_bid
end
