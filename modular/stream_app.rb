require "sinatra"
require "sinatra/base"
require "sinatra/streaming"

class StreamApp < Sinatra::Base
  helpers Sinatra::Streaming
end
