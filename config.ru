$stdout.sync = true
$stderr.sync = true

require "securerandom"

require_relative "lib/dump_env"

require_relative "modular/test_app"
require_relative "modular/protected_app"
require_relative "modular/stream_app"

map "/test" do
  use DumpEnv
  run TestApp
end

map "/p" do
  use DumpEnv
  use Rack::Session::Cookie, secret: SecureRandom.hex

  run ProtectedApp
end

map "/stream" do
  run StreamApp
end

require_relative "classic/feed"
require_relative "classic/latin1"
require_relative "classic/root"

run Sinatra::Application
