# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{gmail_sender}
  s.version = "1.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Daniel Cadenas"]
  s.date = %q{2010-06-03}
  s.default_executable = %q{gmail}
  s.email = %q{dcadenas@gmail.com}
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
     "bin/gmail",
     "gmail_sender.gemspec",
     "lib/gmail_sender.rb",
     "lib/gmail_sender/error.rb",
     "lib/gmail_sender/message_stream_writer.rb",
     "lib/gmail_sender/utils.rb",
     "lib/tls_smtp_patch.rb",
     "test/gmail_sender_test.rb",
     "test/message_stream_writer_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/dcadenas/gmail_sender}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{A simple gem to send email through gmail}
  s.test_files = [
    "test/gmail_sender_test.rb",
     "test/message_stream_writer_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<expectations>, [">= 0"])
      s.add_development_dependency(%q<filetesthelper>, [">= 0"])
    else
      s.add_dependency(%q<expectations>, [">= 0"])
      s.add_dependency(%q<filetesthelper>, [">= 0"])
    end
  else
    s.add_dependency(%q<expectations>, [">= 0"])
    s.add_dependency(%q<filetesthelper>, [">= 0"])
  end
end

