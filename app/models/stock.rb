class Stock < ApplicationRecord
  has_many :user_stocks, dependent: :destroy
  validates :company_name, presence: true
  validates :ticker, presence: true, uniqueness: true
  validates :stock_price, presence: true

  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: ENV['IEX_PUBLISHABLE_TOKEN'],
      secret_token: ENV['IEX_SECRET_TOKEN'],
      endpoint: 'https://sandbox.iexapis.com/v1'
    )
    begin
      create(ticker: client.company(ticker_symbol).symbol, company_name: client.company(ticker_symbol).company_name, stock_price: client.price(ticker_symbol))
    rescue StandardError
      nil
    end
  end
end
