module Spree
  Product.class_eval do
    attr_reader :apply_sale_for_variants
    def apply_sale_for_variants=(string_value)
      @apply_sale_for_variants = (string_value == '1')
    end

    delegate_belongs_to :master, :sale_price, :sale_rate, :sale_date, :orig_price_in

    after_save :apply_sale_for_variants_if_any

    def apply_sale_for_variants_if_any
      if apply_sale_for_variants
        variants.each do |variant|
          variant.sale_rate = sale_rate
          variant.sale_date = sale_date
          variant.save
        end
      end
    end

    def sale_off?
      !(sale_date.nil? || sale_date.future?) && sale_rate.to_f > 0
    end
  end
end
