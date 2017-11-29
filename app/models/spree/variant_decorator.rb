module Spree
  Variant.class_eval do
    scope :sale_off, -> { where('sale_rate > 0').where.not(sale_date: nil).where('sale_date < ?', DateTime.now) }

    alias_method :orig_price_in, :price_in
    def price_in(currency)
      return orig_price_in(currency) unless sale_off?
      orig_amount = orig_price_in(currency).amount || 0.0
      sale_amount = orig_amount - (orig_amount * sale_rate.to_f)
      sale_amount_rounded = BigDecimal.new(sale_amount.to_s).round(0, BigDecimal::ROUND_HALF_DOWN)
      Spree::Price.new(:variant_id => self.id, :amount => sale_amount_rounded, :currency => currency)
    end

    before_save :calculate_sale_price
    def calculate_sale_price
      if sale_rate.to_f > 0
        self.sale_price = Spree::Money.new(price - (price * sale_rate.to_f)).money.dollars
      else
        self.sale_price = nil
      end
    end

    after_save :make_product_on_sale
    def make_product_on_sale
      is_on_sale = product.variants_including_master.sale_off.count > 0
      # product.on_sale = is_on_sale
      product.update_column(:on_sale, is_on_sale)
    end

    def sale_off?
      !(sale_date.nil? || sale_date.future?) && sale_rate.to_f > 0
    end

  end
end
