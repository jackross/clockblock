# -*- encoding: utf-8 -*-
require File.expand_path('../lib/clockblock/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jack A Ross"]
  gem.email         = ["jack.ross@technekes.com"]
  gem.description   = %q{Enables easy and DRY code timing capabilities.}
  gem.summary       = %q{Wrap your code in a Clock Block to measure execution duration.}
  gem.homepage      = "https://github.com/jackross/clockblock"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "clockblock"
  gem.require_paths = ["lib"]
  gem.version       = Clockblock::VERSION
  gem.add_development_dependency "rake"
  gem.add_development_dependency "minitest"
  gem.add_development_dependency "turn"
end
