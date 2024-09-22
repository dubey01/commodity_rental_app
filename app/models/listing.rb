# frozen_string_literal: true

# class for managing listings of users as lenders
class Listing < ApplicationRecord
  belongs_to :lender, class_name: 'User', foreign_key: 'lender_id'
  belongs_to :commodity
end
