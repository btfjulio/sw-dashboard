# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'pry'

def call_api()
    url = "https://savewhey-api.herokuapp.com/api/v1/stores/1/suplementos?user_email=btfjulio@hotmail.com&user_token=ycMK41aheobQSHRCycz-"
    suple_serialized = open(url).read
    suplementos = JSON.parse(suple_serialized, {:symbolize_names => true})
    suplementos.each do |suplemento|
        if Suplemento.where(store_code: suplemento[:store_code]).empty?
            save(suplemento)
        else
            update(suplemento)
        end
    end
end

def save(suplemento)
    product = Suplemento.new(
        name:   suplemento[:name],
        link:   suplemento[:link],
        store_code:   suplemento[:store_code],
        seller:   suplemento[:seller],
        weight: suplemento[:weight],
        flavor: suplemento[:flavor],
        brand:  suplemento[:brand],
        price: suplemento[:price][:fractional].to_i/1000,
        photo: suplemento[:photo],
        store_id: 1 
        )
    product.valid?
    begin
        product.save!
    rescue => e
    end        
    puts "Product #{product[:name]} saved on DB"
end

def update(suplemento)
    product = Suplemento.where(store_code: suplemento[:store_code]).first
    begin
        product.name = suplemento[:name]
        product.link = suplemento[:link]
        product.store_code = suplemento[:store_code]    
        product.seller = suplemento[:seller]
        product.weight = suplemento[:weight]
        product.flavor = suplemento[:flavor]
        product.brand = suplemento[:brand]
        product.price = suplemento[:price][:fractional].to_i/1000
        product.price_changed = product.price_cents_changed?
        product.photo = suplemento[:photo]
        product.store_id = 1    
    rescue => e
    end 
    product.save
    puts "Product #{product[:name]} updated on DB"
end

call_api()
puts 'DB UPDATED'