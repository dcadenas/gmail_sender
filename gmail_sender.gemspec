# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{gmail_sender}
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Daniel Cadenas", "Felipe Coury"]
  s.date = %q{2009-05-25}
  s.email = %q{dcadenas@gmail.com felipe.coury@gmail.com}
  s.bindir = "bin"
  s.executables = ["gmail"]
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "gmail_sender.gemspec",
     "bin/gmail",
     "lib/gmail_sender.rb",
     "lib/tls_smtp_patch.rb",
     "test/gmail_sender_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/dcadenas/gmail_sender}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.3}
  s.summary = s.description = %q{A simple gem to send email through gmail}
  s.test_files = [
    "test/gmail_sender_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<choice>, [">= 0"])
    else
    end
  else
  end
end
