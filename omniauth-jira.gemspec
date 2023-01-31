# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-jira/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Rich Manalang", "Joel Van Horn"]
  gem.email         = ["rmanalang@atlassian.com", "joel@joelvanhorn.com"]
  gem.description   = %q{A JIRA OAuth 1.0a strategy for OmniAuth.}
  gem.summary       = %q{A JIRA OAuth 1.0a strategy for OmniAuth.}
  gem.homepage      = "https://github.com/manalang/omniauth-jira"

  gem.add_dependency             'multi_json', '~> 1.3'
  gem.add_runtime_dependency     'omniauth'
  gem.add_runtime_dependency     'omniauth-oauth'
  gem.add_runtime_dependency     'oauth'
  gem.add_development_dependency 'rspec', '~> 2.7'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'rake'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "omniauth-jira"
  gem.require_paths = ["lib"]
  gem.version       = OmniAuth::JIRA::VERSION
end
