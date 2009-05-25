require 'rubygems'
require 'expectations'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'gmail_sender'

class Test::Unit::TestCase
end
