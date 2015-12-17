module Spree
  Product.class_eval do
    attr_reader :apply_sale_for_variants
    def apply_sale_for_variants=(string_value)
      @apply_sale_for_variants = (string_value == '1')
    end

    delegate_belongs_to :master, :sale_price, :sale_rate

    after_save :apply_sale_for_variants_if_any

    def apply_sale_for_variants_if_any
      if apply_sale_for_variants
        variants.each do |variant|
          variant.sale_rate = sale_rate
          variant.save
        end
      end
    end
  end
end