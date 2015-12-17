Deface::Override.new(:virtual_path => 'spree/admin/variants/_form',
  :name => 'add_sale_rate_to_variant_edit',
  :insert_after => "[data-hook='price']",
  :text => "
    <div class='form-group'>
      <%= f.label :sale_rate, Spree.t(:sale_rate) %>
      <%= f.text_field :sale_rate, :value => @variant.sale_rate, :class => 'form-control' %>
      <p class='help-block'>
        Sale rates are a decimal amount to aid in calculations, (i.e. if the sale rate is 5% then enter 0.05)
      </p>
    </div>
  ")