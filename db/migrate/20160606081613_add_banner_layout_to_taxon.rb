class AddBannerLayoutToTaxon < ActiveRecord::Migration
  def change
    add_column :spree_taxons, :banner_layout, :string
    add_column :spree_taxons, :banners_count, :integer, default: 0
  end
end
