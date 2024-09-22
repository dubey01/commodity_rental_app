# frozen_string_literal: true

# create renter_bids table migration
class CreateRenterBids < ActiveRecord::Migration[5.2]
  def change
    create_table :renter_bids do |t|
      t.references :renter, foreign_key: { to_table: :users }, index: true
      t.belongs_to :listing

      t.float :bid_price, null: false
      t.integer :lease_period_in_month, default: 1

      t.timestamps
    end
  end
end
