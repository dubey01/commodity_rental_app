# frozen_string_literal: true

# class for managing bids by users as renters
class RenterBid < ApplicationRecord
  belongs_to :renter, class_name: 'User', foreign_key: 'renter_id'
  belongs_to :listing
end
