class CreateCommodities < ActiveRecord::Migration[5.2]
  def change
    create_table :commodities do |t|

      t.timestamps
    end
  end
end
