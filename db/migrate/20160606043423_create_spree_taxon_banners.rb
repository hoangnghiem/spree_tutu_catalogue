class CreateSpreeTaxonBanners < ActiveRecord::Migration
  def change
    create_table :spree_taxon_banners do |t|
      t.references :taxon, index: true
      t.string :link
      t.attachment :banner

      t.timestamps null: false
    end

    add_foreign_key :spree_taxon_banners, :spree_taxons, column: :taxon_id
  end
end
