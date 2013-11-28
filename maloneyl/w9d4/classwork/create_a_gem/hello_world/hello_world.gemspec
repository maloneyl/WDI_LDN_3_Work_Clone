# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hello_world/version'

Gem::Specification.new do |spec|
  spec.name          = "hello_world"
  spec.version       = HelloWorld::VERSION
  spec.authors       = ["maloneyl"]
  spec.email         = ["m@thinkmaloney.com"]
  spec.description   = %q{This gem can say hello in more than 100 languages.} # won't be able to submit to Ruby with 'TODO: Write...' still in place
  spec.summary       = %q{I'm sorry I have no clue what I should put here.} # see above
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/) # whatever we 'git add'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  # default
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  # custom dependencies: e.g.
  # spec.add_dependency "devise"
end
