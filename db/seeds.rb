# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!([
  {
    email: "admin@stockonyou.com",
    username: "admin",
    firstname: "admin",
    lastname: "stockonyou",
    role: 0,
    status: 1,
    password: "123456",
    password_confirmation: "123456"
  },
  {
    email: "trader@stockonyou.com",
    username: "trader",
    firstname: "trader",
    lastname: "stockonyou",
    role: 1,
    status: 0,
    password: "123456",
    password_confirmation: "123456"
  },
])

require 'json'
require 'open-uri'

url = "https://sandbox.iexapis.com/beta/ref-data/symbols?token=#{ENV['IEX_PUBLISHABLE_TOKEN']}"
stock_ids = open(url).read
stocks = JSON.parse(stock_ids)

5000.times do |index|
  stock_id = stocks[index]
  client = IEX::Api::Client.new(
  publishable_token: ENV['IEX_PUBLISHABLE_TOKEN'],
  secret_token: ENV['IEX_SECRET_TOKEN'],
  endpoint: 'https://sandbox.iexapis.com/v1'
  )
  begin
    Stock.create(ticker: client.company(stocks[index]["symbol"]).symbol, company_name: client.company(stocks[index]["symbol"]).company_name, stock_price: client.price(stocks[index]["symbol"]))
  rescue StandardError
    nil
  end
end