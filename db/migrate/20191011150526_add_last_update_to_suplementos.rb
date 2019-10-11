class AddLastUpdateToSuplementos < ActiveRecord::Migration[5.2]
  def change
    add_column :suplementos, :last_update, :datetime
  end
end
