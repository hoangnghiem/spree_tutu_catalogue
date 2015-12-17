class AddOnSaleToSpreeProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :on_sale, :boolean, default: false
  end
end
