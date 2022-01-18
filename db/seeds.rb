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
