class HomeController < ApplicationController
  def index
    @furnitures = [
      {
        name: 'โต๊ะทำงาน ขนาด 80 ซม. รุ่น AIDEN สีไม้อ่อน',
        image_url: 'https://www.konceptfurniture.com/media/catalog/product/1/9/19209768-02_1.jpg?quality=85&fit=bounds&height=700&width=700&canvas=700:700',
        price: 790.0,
        stock: 5
      },
      {
        name: 'ชุดห้องนอน ขนาด 5 ฟุต รุ่น Haley สีไม้อ่อน',
        image_url: 'https://www.konceptfurniture.com/media/catalog/product/5/9/59057047-furniture-bedroom-furniture-bedroom-sets-31_3.jpg?quality=85&fit=bounds&height=700&width=700&canvas=700:700',
        price: 12_900.0,
        stock: 10
      },
      {
        name: 'โซฟาผ้า 2 ที่นั่ง Canit สีเทา',
        image_url: 'https://www.konceptfurniture.com/media/catalog/product/5/9/59057047-furniture-bedroom-furniture-bedroom-sets-31_3.jpg?quality=85&fit=bounds&height=700&width=700&canvas=700:700',
        price: 9_590.0,
        stock: 10
      },
    ]
  end
end