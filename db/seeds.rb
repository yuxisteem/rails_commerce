# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Store initial data

Category.create(name: 'Default', description: 'Default category', active: true)

Brand.create(name: 'Default', description: 'Default category')

Page.create(title: 'About', text: 'Default page', seo_url: 'about')

User.create(email: 'paul@live.ru',
            first_name: 'Pavel',
            last_name: 'D',
            password: '12345',
            password_confirmation: '12345',
            admin: true)
