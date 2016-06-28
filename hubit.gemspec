# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hubit/version'

Gem::Specification.new do |spec|
  spec.name          = 'hubit'
  spec.version       = Hubit::VERSION
  spec.authors       = ['Wayne Allan']
  spec.email         = ['wayne.allan@rea-group.com']

  spec.summary       = 'Setup and manage delivery stats for GitHub projects.'
  spec.description   = 'Setup and manage delivery stats for GitHub projects: '\
                       'setup tags, run reports, manage milestones.'
  spec.homepage      = 'http://rubygems.org/gems/hubit'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.41'

  #  spec.add_runtime_dependency 'example', '~> 1.1', '>= 1.1.4'
end