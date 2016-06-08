class Spree::TaxonBanner < ActiveRecord::Base
  belongs_to :taxon, class_name: 'Spree::Taxon', counter_cache: :banners_count

  has_attached_file :banner,
                    url: '/spree/taxon_banner/:id/:basename.:extension',
                    path: ':rails_root/public/spree/taxon_banner/:id/:basename.:extension'
                    # convert_options: { all: '-strip -auto-orient -colorspace sRGB' }

  validates_attachment :banner,
                       :presence => true,
                       :content_type => { :content_type => %w(image/jpeg image/jpg image/png image/gif) }
  
end
