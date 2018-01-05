
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "stocks_exchange/version"

Gem::Specification.new do |spec|
  spec.name          = "stocks_exchange"
  spec.version       = StocksExchange::VERSION
  spec.authors       = ["alabeco"]
  spec.email         = ["alabecocliquebuster@gmail.com"]

  spec.summary       = %q{Ease the use of stocks.exchange public api}
  spec.description   = %q{Easily consume the public API of https://stocks.exchange to give a ruby friendly version}
  spec.homepage      = "https://github.com/alabeco/stocks_exchange"
  spec.license       = "MIT"



  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty","~> 0.15.6"
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
end
