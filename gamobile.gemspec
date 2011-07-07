# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "gamobile/version"

Gem::Specification.new do |s|
  s.name        = "gamobile"
  s.version     = Gamobile::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["terut"]
  s.email       = ["terut.dev+github@gmail.com"]
  s.homepage    = "https://github.com/terut/gamobile"
  s.summary     = %q{Google Analytics for japanese mobile with rails3}
  s.description = %q{Google Analytics for japanese mobile. This gem rewrite ga.php for rails3 and require jpmobile.}

  s.rubyforge_project = "gamobile"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
 
  s.licenses = ['MIT']

  s.add_dependency 'rails', ['>= 3.0.7']
  s.add_dependency 'jpmobile', ['>= 0.1.6']
  s.add_development_dependency 'bundler', ['>= 1.0.10']
  s.add_development_dependency 'rspec', ['>= 0']
  s.add_development_dependency 'rspec-rails', ['>= 0']
  s.add_development_dependency 'prefetch-rspec', ['>= 0']
  s.add_development_dependency 'watchr', ['>= 0']
end
