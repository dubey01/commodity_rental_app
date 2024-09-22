# frozen_string_literal: true

# class migration for adding description column in commodities table
class AddColumnDescriptionInCommodities < ActiveRecord::Migration[5.2]
  def change
    add_column :commodities, :description, :text
  end
end
