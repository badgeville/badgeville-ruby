# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "badgeville/version"

Gem::Specification.new do |s|
  s.name        = "badgeville"
  s.version     = Badgeville::VERSION
  s.authors     = ["David Czarnecki"]
  s.email       = ["dczarnecki@agoragames.com"]
  s.homepage    = "https://github.com/badgeville/badgeville-ruby"
  s.summary     = %q{Ruby API for interacting with Badgeville}
  s.description = %q{Ruby API for interacting with Badgeville}

  s.rubyforge_project = "badgeville"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency('rake')
  s.add_development_dependency('rspec')
  s.add_development_dependency('vcr', '2.0.0.rc1')

  s.add_dependency('typhoeus')
end
