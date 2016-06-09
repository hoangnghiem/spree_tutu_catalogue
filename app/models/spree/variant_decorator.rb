module Spree
  Variant.class_eval do
    scope :sale_off, -> { where('sale_rate > 0').where.not(sale_date: nil).where('sale_date < ?', DateTime.now) }

    alias_method :orig_price_in, :price_in
    def price_in(currency)
      return orig_price_in(currency) unless sale_off?
      Spree::Price.new(:variant_id => self.id, :amount => self.sale_price, :currency => currency)
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
      product.on_sale = is_on_sale
      product.save
    end

    def sale_off?
      !(sale_date.nil? || sale_date.future?) && sale_rate.to_f > 0
    end

  end
end
