namespace :db do
  desc "Insert demo data to DB"
  task demo: :environment do
    # Fake data
    def random_number
      Faker::Number.number(3)
    end

    def random_name
      Faker::Lorem.word.to_s.capitalize
    end

    def random_desc(words_count = 5)
      Faker::Lorem.sentence(words_count).to_s
    end

    def build_random_address
      Address.new(city: Faker::Address.city,
                  street: Faker::Address.street_address,
                  phone:  Faker::PhoneNumber.cell_phone)
    end

    def build_order_items
      @products_count ||= Product.all.count
      items = 5.times.map do
        OrderItem.new(product_id: rand(@products_count-1)+1,
                      price: random_number,
                      quantity: rand(5))
      end
      items
    end


    puts "Creating users..."

    User.create(first_name: 'Paul',
                last_name: 'D',
                email: 'paul@live.ru',
                admin: true,
                password: '12345',
                password_confirmation: '12345',
                phone: '+380666018206').save

    User.transaction do
      50.times do
        User.create(first_name: Faker::Name.first_name,
                    last_name: Faker::Name.last_name,
                    email: Faker::Internet.email,
                    password: '12345',
                    password_confirmation: '12345').save
      end
    end

    puts "Creating categories..."

    categories = []
    Category.transaction do
      %w(Mobile Photo Accessories Tablets Other).each do |category_name|
        categories.append(Category.create(name: category_name, description: random_desc, active: true))
      end
    end

    # Add attributes to categories
    Category.transaction do
      categories.each do |category|
        5.times do
          category
            .product_attribute_names << ProductAttributeName.new(name: random_name, filterable: true)
        end
      end
    end

    puts "Creating brands..."

    brands = []
    Brand.transaction do
      10.times do
        brands.append(Brand.create(name: random_name, description: random_desc))
      end
    end

    puts "Creating products..."
    random_attr_vals = 10.times.map { random_name }
    Product.transaction do
      500.times do
        product = Product.new(name: random_name,
                       description: random_desc(11),
                       price: random_number,
                       category: categories.at(rand(categories.count)),
                       brand: brands.at(rand(brands.count)),
                       active: true)
        product.product_attribute_values = product
                                              .available_attributes
                                              .map { |val| val.update(value: random_attr_vals.sample); val }
        product.save
      end
    end

    puts "Creating orders..."

    Order.transaction do
      users_count = User.all.count
      500.times do
        Order.create(user_id: rand(users_count - 1) + 1, address: build_random_address, order_items: build_order_items)
      end
    end

    puts 'Demo data created'
  end

end
