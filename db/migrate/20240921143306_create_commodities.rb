# frozen_string_literal: true

# create commodities table migration
class CreateCommodities < ActiveRecord::Migration[5.2]
  def change
    create_table :commodities do |t|
      t.string :name
      t.belongs_to :category
      t.string :make

      t.boolean :active

      t.timestamps
    end
  end
end
