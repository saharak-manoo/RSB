if User.count.zero?
  admin_user = User.new(
    email: "admin@rsb.com",
    first_name: "Admin",
    last_name: "rsb",
    password: "admin12345678",
    confirmed_at: DateTime.now
  )

  admin_user.save!
  admin_user.add_role(:admin)
  puts "Create user #{admin_user.email}"
end

if Branch.count.zero?
  branchs = [
    {
      name: "สาขาใหญ่"
    },
    {
      name: "สาขาตัวเมือง อุบล"
    }
  ]

  Branch.create(branchs)
end

if Product.count.zero?
  products = [
    {
      name: 'โต๊ะทำงาน ขนาด 80 ซม. รุ่น AIDEN สีไม้อ่อน',
      image_url: 'https://www.konceptfurniture.com/media/catalog/product/1/9/19209768-02_1.jpg?quality=85&fit=bounds&height=700&width=700&canvas=700:700',
      price: 790.0
    },
    {
      name: 'ชุดห้องนอน ขนาด 5 ฟุต รุ่น Haley สีไม้อ่อน',
      image_url: 'https://www.konceptfurniture.com/media/catalog/product/5/9/59057047-furniture-bedroom-furniture-bedroom-sets-31_3.jpg?quality=85&fit=bounds&height=700&width=700&canvas=700:700',
      price: 12_900.0
    },
    {
      name: 'โซฟาผ้า 2 ที่นั่ง Canit สีเทา',
      image_url: 'https://www.konceptfurniture.com/media/catalog/product/5/9/59057047-furniture-bedroom-furniture-bedroom-sets-31_3.jpg?quality=85&fit=bounds&height=700&width=700&canvas=700:700',
      price: 9_590.0
    },
    {
      name: 'เตียงนอน รุ่น KC-PLAY FANTASY ขนาด 3.5 ฟุต สีลินเบิร์ก',
      image_url: 'https://www.konceptfurniture.com/media/catalog/product/f/a/fantasy_lb-03.jpg?quality=85&fit=bounds&height=700&width=700&canvas=700:700',
      price: 3_990.0
    },
    {
      name: 'ชั้นวางทีวี รุ่น KC-PLAY WIB สีโอ๊ค',
      image_url: 'https://www.konceptfurniture.com/media/catalog/product/1/9/19195613-kc-play-furniture-living-room-tv-stands-31_1.jpg?quality=85&fit=bounds&height=700&width=700&canvas=700:700',
      price: 3_990.0
    },
    {
      name: 'โต๊ะทำงาน ขนาด 120 ซม. รุ่น Gimmick',
      image_url: 'https://www.konceptfurniture.com/media/catalog/product/1/9/19106693-gimmick-mattress-bedding-living-room-office-home-office-organization-01.jpg?quality=85&fit=bounds&height=700&width=700&canvas=700:700',
      price: 5_290.0
    }
  ]

  Product.create(products)
end

if BranchProduct.count.zero?
  Product.all.each_with_index do |product, index|
    branch_id = 1
    if index.odd?
      branch_id = 1
    else
      branch_id = 2
    end

    BranchProduct.create(branch_id: branch_id, product_id: product.id, qty: rand(1...50))
  end
end