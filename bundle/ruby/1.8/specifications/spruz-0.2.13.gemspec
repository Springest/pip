# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{spruz}
  s.version = "0.2.13"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Florian Frank"]
  s.date = %q{2011-08-17 00:00:00.000000000Z}
  s.default_executable = %q{enum}
  s.description = %q{All the stuff that isn't good/big enough for a real library.}
  s.email = %q{flori@ping.de}
  s.executables = ["enum"]
  s.files = ["tests/spruz_secure_write_test.rb", "tests/spruz_test.rb", "tests/spruz_file_binary_test.rb", "tests/spruz_lines_file_test.rb", "tests/spruz_memoize_test.rb", "bin/enum"]
  s.homepage = %q{http://flori.github.com/spruz}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Useful stuff.}
  s.test_files = ["tests/spruz_secure_write_test.rb", "tests/spruz_test.rb", "tests/spruz_file_binary_test.rb", "tests/spruz_lines_file_test.rb", "tests/spruz_memoize_test.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<gem_hadar>, ["~> 0.0.11"])
      s.add_development_dependency(%q<test-unit>, ["~> 2.3"])
    else
      s.add_dependency(%q<gem_hadar>, ["~> 0.0.11"])
      s.add_dependency(%q<test-unit>, ["~> 2.3"])
    end
  else
    s.add_dependency(%q<gem_hadar>, ["~> 0.0.11"])
    s.add_dependency(%q<test-unit>, ["~> 2.3"])
  end
end
