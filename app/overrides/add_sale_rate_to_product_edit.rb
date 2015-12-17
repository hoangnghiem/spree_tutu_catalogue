Deface::Override.new(:virtual_path => 'spree/admin/products/_form',
  :name => 'add_sale_rate_to_product_edit',
  :insert_after => "[data-hook='admin_product_form_price']",
  :text => "
    <%= f.field_container :sale_rate, class: ['form-group'] do %>
      <%= f.label :sale_rate %>
      <%= f.text_field :sale_rate, value: @product.sale_rate, class: 'form-control' %>
      <%= f.error_message_on :sale_rate %>
      <p class='help-block'>
        Sale rates are a decimal amount to aid in calculations, (i.e. if the sale rate is 5% then enter 0.05)
      </p>
    <% end %>
    <%= f.field_container :apply_sale_for_variants, class: ['form-group'] do %>
      <%= f.label :apply_sale_for_variants, 'Apply sale for all variants' %>
      <%= f.error_message_on :apply_sale_for_variants %>
      <%= f.check_box :apply_sale_for_variants, class: 'form-control' %>
    <% end %>
  ")