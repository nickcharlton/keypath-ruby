# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'key_path/version'

Gem::Specification.new do |spec|
  spec.name          = 'key_path'
  spec.version       = KeyPath::VERSION
  spec.authors       = ['Nick Charlton']
  spec.email         = ['nick@nickcharlton.net']
  spec.description   = %q{Keypath-based collection access extensions for Ruby.}
  spec.summary       = %q{This gem allows you to access nested Ruby collections 
                          (Hash, Array, etc) using keypaths. E.g.: 'something.item.0'}
  spec.homepage      = 'https://github.com/nickcharlton/keypath-ruby'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport', '~> 4.0'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pry'
end
