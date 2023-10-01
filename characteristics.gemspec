# -*- encoding: utf-8 -*-

require File.dirname(__FILE__) + "/lib/characteristics/version"

Gem::Specification.new do |gem|
  gem.name          = "characteristics"
  gem.version       = Characteristics::VERSION
  gem.summary       = "Basic character properties"
  gem.description   = "Provides basic information about how characters behave in different encodings"
  gem.authors       = ["Jan Lelis"]
  gem.email         = ["hi@ruby.consulting.com"]
  gem.homepage      = "https://github.com/janlelis/characteristics"
  gem.license       = "MIT"

  gem.files         = Dir["{**/}{.*,*}"].select{ |path| File.file?(path) && path !~ /^pkg/ }
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.metadata      = { "rubygems_mfa_required" => "true" }

  gem.required_ruby_version = ">= 2.0"
  gem.add_dependency 'unicode-categories', '~> 1.9'
end
