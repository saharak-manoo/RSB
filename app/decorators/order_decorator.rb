class OrderDecorator < ApplicationDecorator
  delegate_all

  def view_button
    h.link_to h.sale_path(self), class: 'text-warning' do
      "<ion-icon name='create-outline' class='m-2' size='large'></ion-icon>".html_safe
    end
  end
end