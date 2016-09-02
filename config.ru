$stdout.sync = true
$stderr.sync = true

require "sinatra"
require_relative "latin1"
require_relative "hi"

run Sinatra::Application
