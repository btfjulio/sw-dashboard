class AddChangesToPrices < ActiveRecord::Migration[5.2]
  def change
    add_column :prices, :price_change, :integer
  end
end
