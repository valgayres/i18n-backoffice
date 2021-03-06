# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'i18n-backoffice/version'

Gem::Specification.new do |spec|
  spec.name          = 'i18n-backoffice'
  spec.version       = I18n::Backoffice::VERSION
  spec.authors       = ['Vincent']
  spec.email         = ['vincent.algayres@centraliens.net']
  spec.summary       = 'Help manage your translations by enabling to change them directly from your website'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_dependency 'redis'
  spec.add_dependency 'i18n'
  spec.add_dependency 'activesupport', '>= 4.0'
  spec.add_dependency 'sinatra', '~> 1.4', '>= 1.4.6'
  spec.add_dependency 'rails', '~> 4', '>= 3.2.0'
end
