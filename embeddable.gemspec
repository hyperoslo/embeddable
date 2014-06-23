# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'embeddable/version'

Gem::Specification.new do |spec|
  spec.name          = "embeddable"
  spec.version       = Embeddable::VERSION
  spec.authors       = ["Johannes Gorset", "Sindre Moen"]
  spec.email         = ["jgorset@gmail.com", "sindre@hyper.no"]
  spec.description   = "Embeddable makes it easier to embed videos."
  spec.summary       = "Embeddable makes it easier to embed videos."
  spec.homepage      = "http://github.com/hyperoslo/embeddable"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", "~> 4.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-its"
end
