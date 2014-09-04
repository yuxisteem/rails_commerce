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

    def create_random_address
      Address.create(city: Faker::Address.city,
                     street: Faker::Address.street_address,
                     phone:  Faker::PhoneNumber.cell_phone)
    end

    def create_order_items
      items = []
      OrderItem.transaction do
        5.times do
          items << OrderItem.new(product_id: rand(Product.all.count-1)+1,
                                 price: random_number,
                                 quantity: rand(5))
        end
      end
      items
    end

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

    categories = []
    brands = []

    # 10.times do
    #    categories.append(Category.create(name: random_name, description: random_desc))
    # end

    categories.append(Category.create(name: 'Mobile', description: random_desc))
    categories.append(Category.create(name: 'Photo', description: random_desc))
    categories.append(Category.create(name: 'Accessories', description: random_desc))
    categories.append(Category.create(name: 'Tablets', description: random_desc))

    Brand.transaction do
      10.times do
        brands.append(Brand.create(name: random_name, description: random_desc))
      end
    end

    Product.transaction do
      99.times do
        Product.create(name: random_name,
                       description: random_desc(11),
                       price: random_number,
                       category: categories.at(rand(categories.count)),
                       brand: brands.at(rand(brands.count)),
                       active: true).save
      end
    end


    Order.transaction do
      30.times do
        Order.create(user_id: rand(User.all.count - 1) + 1, address: create_random_address, order_items: create_order_items)
      end
    end
    puts 'Demo data created'
  end

end
