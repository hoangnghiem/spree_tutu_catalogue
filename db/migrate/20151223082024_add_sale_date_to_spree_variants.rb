class AddSaleDateToSpreeVariants < ActiveRecord::Migration
  def change
    add_column :spree_variants, :sale_date, :datetime
    add_index :spree_variants, [:sale_date], :name => 'index_spree_variants_on_sale_date'
  end
end
