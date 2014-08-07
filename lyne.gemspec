# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lyne/version'

Gem::Specification.new do |spec|
  spec.name          = "lyne"
  spec.version       = Lyne::VERSION
  spec.authors       = ["soplana"]
  spec.email         = ["sonosheet.jp@gmail.com"]
  spec.summary       = %q{dqx gem}
  spec.description   = %q{冒険者の広場をスクレイピングするgemです}
  spec.homepage      = "http://leeno.jp"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler",       "~> 1.6"
  spec.add_development_dependency "nokogiri",      '~> 1.3'
  spec.add_development_dependency "poltergeist",   '~> 1.5'
  spec.add_development_dependency "capybara",      '~> 2.4'
  spec.add_development_dependency "phantomjs",     '~> 1.9'
  spec.add_development_dependency "activesupport", '~> 4.0'

end
