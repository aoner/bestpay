# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bestpay/version'

Gem::Specification.new do |spec|
  spec.name          = "bestpay"
  spec.version       = Bestpay::VERSION
  spec.authors       = ["H.J.LeoChen"]
  spec.email         = ["hjleochen@hotmail.com"]
  spec.summary       = %q{翼支付网关商户接口实现,非官方}
  spec.description   = %q{翼支付网关商户接口实现,非官方}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.2.10"
  spec.add_development_dependency "rake"
end
