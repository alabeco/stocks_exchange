# StocksExchange

This gem consumes the public API of [stocks.exchange]('https://stocks.exchange') to give you a ruby friendly version.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'stocks_exchange'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install stocks_exchange

## Usage

All [currencies](https://stocks.exchange/api2/currencies) are converted into modules with their respective symbols(in uppercase) as the names.
For example, for a currency, Intensecoin with the symbol ITNS you access it as:

```ruby
StocksExchange::ITNS
```
The corresponding keys are converted into methods that return their values
For example, to get the minimum withdrawal amount for Intensecoin above. You can use:
```ruby
StocksExchange::ITNS.minimum_withdrawal_amount
#=> "<some_value>"
```
since [stocks.exchange](https://stocks.exchange) provides `"minimum_withdrawal_amount":"<some_value>"` in their API.

All [markets](https://stocks.exchange/api2/markets) are converted into modules with their respective market names(as in the API, in uppercase) as the names.
For example, for a market, DERO/BTC, you can access it as:
```ruby
StocksExchange::DERO_BTC
```
The corresponding keys are converted into methods that return their values.
The values from the [ticker](https://stocks.exchange/api2/ticker) and [prices](https://stocks.exchange/api2/prices) are also added to their respective market names.
Examples:

```ruby
#to get buy fee percentage
#sample from API: "buy_fee_percent":"0.2"
StocksExchange::DERO_BTC.buy_fee_percent
#=> "0.2"

#to get market volume from ticker url
#sample from API: "vol":"240114.98504904"
StocksExchange::DERO_BTC.vol
#=> "240114.98504904"

#to get buy price from prices url
#sample from API:  "buy":"0.000142"
StocksExchange::DERO_BTC.buy
#=> "0.000142"
```

### Other Methods

It is important to keep updating the values since the initital values are the values grabbed during gem load time.
To do so, use:
```ruby
StocksExchange.refresh
#=> true
```
To check whether a market or currency exists use:

```ruby
#StocksExchange.listed?(<coin_symbol or market_name>)
StocksExchange.listed?("ITNS_BTC")
#=> true
StocksExchange.listed?("dhjdcdhjcbhsjcb")
#=> false
```


## Contributing

1. Fork it ( https://github.com/alabeco/stocks_exchange/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

Bug reports and pull requests are welcome on GitHub at https://github.com/alabeco/stocks_exchange.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
