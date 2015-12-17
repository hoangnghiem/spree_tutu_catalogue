module Spree
  Variant.class_eval do
    alias_method :orig_price_in, :price_in
    def price_in(currency)
      return orig_price_in(currency) unless sale_price.present?
      Spree::Price.new(:variant_id => self.id, :amount => self.sale_price, :currency => currency)
    end

    before_save :calculate_sale_price
    def calculate_sale_price
      puts "sale_rate = #{sale_rate}"
      if sale_rate.to_f > 0
        self.sale_price = Spree::Money.new(price - (price * sale_rate.to_f)).money.dollars
      else
        self.sale_price = nil
      end
    end

    after_save :make_product_on_sale
    def make_product_on_sale
      is_on_sale = product.variants_including_master.where('sale_rate > 0').count > 0
      product.update_column(:on_sale, is_on_sale)
    end

  end
end