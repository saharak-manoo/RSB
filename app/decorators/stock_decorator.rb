class StockDecorator < ApplicationDecorator
  delegate_all

  def edit_button
    h.link_to h.new_stock_stock_history_path(self), class: 'text-warning' do
      "<ion-icon name='create-outline' size='large'></ion-icon>".html_safe
    end
  end

  def edit_button
    h.link_to h.new_stock_stock_history_path(self), class: 'text-warning' do
      "<ion-icon name='create-outline' size='large'></ion-icon>".html_safe
    end
  end

  def action_button
    "<div class='btn-group btn-group-toggle'>
    </div>".html_safe
  end
end