require 'rubygems'
require 'expectations'
require 'file_test_helper'
include FileTestHelper

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'gmail_sender'
