class AddPromoToSuplementos < ActiveRecord::Migration[5.2]
  def change
    add_column :prices, :promo, :string
  end
end
