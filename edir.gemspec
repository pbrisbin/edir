# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'edir/version'

Gem::Specification.new do |spec|
  spec.name          = "edir"
  spec.version       = Edir::VERSION
  spec.authors       = ["Patrick Brisbin"]
  spec.email         = ["pbrisbin@gmail.com"]
  spec.description   = %q{Edit a directory}
  spec.summary       = %q{Edit a directory listing in your $EDITOR and have those changes reflected in the file system}
  spec.homepage      = "https://github.com/pbrisbin/edir"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
