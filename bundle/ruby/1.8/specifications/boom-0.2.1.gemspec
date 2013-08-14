# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{boom}
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Zach Holman"]
  s.date = %q{2011-07-15}
  s.default_executable = %q{boom}
  s.description = %q{God it's about every day where I think to myself, gadzooks,
  I keep typing *REPETITIVE_BORING_TASK* over and over. Wouldn't it be great if
  I had something like boom to store all these commonly-used text snippets for
  me? Then I realized that was a worthless idea since boom hadn't been created
  yet and I had no idea what that statement meant. At some point I found the
  code for boom in a dark alleyway and released it under my own name because I
  wanted to look smart.}
  s.email = %q{github.com@zachholman.com}
  s.executables = ["boom"]
  s.files = ["test/test_color.rb", "test/test_command.rb", "test/test_config.rb", "test/test_item.rb", "test/test_list.rb", "test/test_platform.rb", "bin/boom"]
  s.homepage = %q{https://github.com/holman/boom}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{boom}
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{boom lets you access text snippets over your command line.}
  s.test_files = ["test/test_color.rb", "test/test_command.rb", "test/test_config.rb", "test/test_item.rb", "test/test_list.rb", "test/test_platform.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 2

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<json_pure>, ["~> 1.5.1"])
      s.add_development_dependency(%q<mocha>, ["~> 0.9.9"])
    else
      s.add_dependency(%q<json_pure>, ["~> 1.5.1"])
      s.add_dependency(%q<mocha>, ["~> 0.9.9"])
    end
  else
    s.add_dependency(%q<json_pure>, ["~> 1.5.1"])
    s.add_dependency(%q<mocha>, ["~> 0.9.9"])
  end
end
