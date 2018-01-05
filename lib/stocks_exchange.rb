require "stocks_exchange/version"
require "httparty"

$VERBOSE=nil #silence "warning: already initialized constant" appearing during refresh

module StocksExchange
  include HTTParty
  @base_uri="https://stocks.exchange/api2"

  #updates the values of modules and functions
  def self.refresh
    begin
      setup_currencies
      setup_markets
      return true
    rescue => e
      puts "StocksExchange failed to load required Modules and Methods. Error: #{e.message}"
      return false
    end
  end

  #checks whether a market or currency is present
  def self.listed?(name)
    StocksExchange.const_defined?("#{name}".upcase)
  end

  #gets all available currencies from https://stocks.exchange/api2/currencies  and creates dynamic modules with dynamic methods as from the API
  def self.setup_currencies
    setup("/currencies")
  end

  #gets all available markets from https://stocks.exchange/api2/currencies and sets their respective modules and methods as #self.setup_currencies above
  #the markets are then supplimentented with values from ticker and prices
  def self.setup_markets
    setup("/markets")
    setup_ticker
    setup_prices
  end

  #add methods from https://stocks.exchange/api2/ticker to respective markets(Modules) created in #self.setup_markets above
  #if market does not exist for some reason, it is created
  def self.setup_ticker
    suppliment("/ticker")
  end

  #add methods from https://stocks.exchange/api2/prices to respective markets(Modules) created in #self.setup_markets above
  #if market does not exist for some reason, it is created
  def self.setup_prices
    suppliment("/prices")
  end

  private

  #setup_currencies
  #setup_markets
  def self.setup(path)
    get("#@base_uri#{path}").parsed_response.each do |response|
      case path
      when "/currencies"
        module_name = response['currency'].upcase
      when "/markets"
        module_name = "#{response['currency'].upcase}_#{response['partner']}"
      else
        return false
      end
      StocksExchange.const_set(module_name, Module.new{
        response.map{|key,value| define_singleton_method(key){value}}
        })
    end

    return true
  end

  #setup_ticker
  #setup_prices
  def self.suppliment(path)
    get("#@base_uri#{path}").parsed_response.each do |response|
      if StocksExchange.const_defined?(response['market_name'].upcase)
        current_module=StocksExchange.const_get(response['market_name'].upcase)
        response.map{|key,value| current_module.define_singleton_method(key){value}}
        current_module=nil
      else
        StocksExchange.const_set(response['market_name'].upcase, Module.new(response.map{|key,value| define_singleton_method(key){value}}))
      end
    end
    return true
  end

  #do the initital setup
  refresh

end
