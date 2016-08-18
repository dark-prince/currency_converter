# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'currency_converter/version'

Gem::Specification.new do |spec|
  spec.name                   = "currency_converter"
  spec.version                = CurrencyConverter::VERSION.dup
  spec.platform               = Gem::Platform::RUBY
  spec.license                = "MIT"
  
  spec.authors                = ["Diganta Mandal"]
  spec.email                  = ["urs.diganta@gmail.com"]
  spec.description            = %q{Google provides a web site to converts currencies using exchange rates but they have not provided any API for ruby. This is a small library that converts currencies exchange rate. You can convert currencies directly through this library.}
  spec.summary                = %q{Google provides a web site to converts currencies using exchange rates but they have not provided any API for ruby. This is a small library that converts currencies exchange rate. You can convert currencies directly through this library.}
  spec.homepage               = "https://github.com/dark-prince/currency_converter"
  
  spec.files                  = `git ls-files`.split($/)
  spec.executables            = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files             = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths          = ["lib"]

  spec.required_ruby_version  = ">= 1.8.7"
  spec.add_dependency 'nokogiri'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "yard", "~> 0.8"
  spec.add_development_dependency "kramdown", "~> 1.1"
end
