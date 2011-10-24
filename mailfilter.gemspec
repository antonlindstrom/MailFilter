# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mailfilter/version"

Gem::Specification.new do |s|
  s.name        = "mailfilter"
  s.version     = MailFilter::VERSION
  s.authors     = ["Anton Lindstrom"]
  s.email       = ["github@antonlindstrom.com"]
  s.homepage    = "http://github.com/antonlindstrom/mailfilter"
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "mailfilter"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here;
  s.add_development_dependency('mocha', "~> 0.9.9")
  s.add_development_dependency('rake', "~> 0.9.2")
  s.add_runtime_dependency "multi_json"
  s.add_runtime_dependency "fileutils"
  s.add_runtime_dependency "logger"
end
