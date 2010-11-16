require 'rubygems'
require 'expectations'
begin
require 'file_test_helper'
rescue LoadError
  puts "Please install filetesthelper to run the tests: gem install filetesthelper"
  exit 1
end

include FileTestHelper

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'gmail_sender'
