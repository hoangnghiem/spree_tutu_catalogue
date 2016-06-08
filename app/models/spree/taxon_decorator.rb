module Spree
  Taxon.class_eval do
    has_many :banners, class_name: 'Spree::TaxonBanner', dependent: :destroy
    accepts_nested_attributes_for :banners, reject_if: proc { |attributes| attributes['banner'].blank? }, allow_destroy: true
  end
end
