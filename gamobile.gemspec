# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "gamobile/version"

Gem::Specification.new do |s|
  s.name        = "gamobile"
  s.version     = Gamobile::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["terut"]
  s.email       = ["terut.dev+github@gmail.com"]
  s.homepage    = "http://www.terut.net/"
  s.summary     = %q{Google Analytics for japanese mobile with rails}
  s.description = %q{Google Analytics for japanese mobile. This gem rewrite ga.php for rails and require jpmobile.}

  s.rubyforge_project = "gamobile"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
