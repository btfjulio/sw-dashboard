class RemovePriceFromPrice < ActiveRecord::Migration[5.2]
  def change
    remove_column :prices, :price, :integer
  end
end
