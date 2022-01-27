class StockDecorator < ApplicationDecorator
  delegate_all

  def edit_button
    h.link_to h.new_stock_stock_history_path(self), class: 'text-warning' do
      "<ion-icon name='create-outline' class='m-2' size='large'></ion-icon>".html_safe
    end
  end

  def log_button
    h.link_to h.logs_stock_path(self), class: 'text-primary' do
      "<ion-icon name='recording-outline' class='m-2' size='large'></ion-icon>".html_safe
    end
  end

  def action_button
    "<div class='btn-group btn-group-toggle'>
      #{log_button}
      #{edit_button}
    </div>".html_safe
  end
end