# frozen_string_literal: true

# create listings table migration
class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.references :lender, foreign_key: { to_table: :users }, index: true
      t.belongs_to :commodity

      t.float :price_per_month, null: false
      t.integer :strategy

      t.timestamps
    end
  end
end
