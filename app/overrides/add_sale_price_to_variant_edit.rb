Deface::Override.new(:virtual_path => 'spree/admin/variants/_form',
  :name => 'add_sale_price_to_variant_edit',
  :insert_after => "[data-hook='price']",
  :text => "
    <div class='form-group'>
      <%= f.label :sale_price, Spree.t(:sale_price) %>
      <%= f.text_field :sale_price, :value => number_to_currency(@variant.sale_price, :unit => ''), :class => 'form-control' %>
    </div>
  ")