$stdout.sync = true
$stderr.sync = true

require_relative "modular/test_app"
require_relative "modular/stream_app"

map "/test" do
  run TestApp
end

map "/stream" do
  run StreamApp
end

require_relative "classic/feed"
require_relative "classic/latin1"
require_relative "classic/root"

run Sinatra::Application
