class AddSaleRateToSpreeVariants < ActiveRecord::Migration
  def change
    add_column :spree_variants, :sale_rate, :decimal, :precision => 8, :scale => 5
  end
end
