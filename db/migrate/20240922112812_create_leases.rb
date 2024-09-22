# frozen_string_literal: true

# create leases table migration
class CreateLeases < ActiveRecord::Migration[5.2]
  def change
    create_table :leases do |t|
      t.belongs_to :listing
      t.belongs_to :renter_bid

      t.boolean :active, default: true

      t.timestamps
    end
  end
end
