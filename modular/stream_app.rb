require "sinatra"
require "sinatra/base"
require "sinatra/streaming"

require "net/http"

class StreamApp < Sinatra::Base
  helpers Sinatra::Streaming

  HOST = development? ? "127.0.0.1:5000" : "huvud.starkast.net"

  get "/" do
    stream_while_waiting do
      fetch_response
    end
  end

  get "/fetch" do
    body fetch_data
  end

  get %r{\/data(\/)?(\d+)?} do
    seconds = params.fetch("captures").last || 3
    sleep seconds.to_i

    body "data after #{seconds} seconds"
  end

  helpers do
    def stream_while_waiting
      stream do |out|
        keep_alive_thread = Thread.new do
          loop do
            out.puts "."
            sleep 1
          rescue Errno::EPIPE
            break
          end
        end

        # keep_alive_thread.report_on_exception = false
        keep_alive_thread.run

        response = yield

        keep_alive_thread.kill
        keep_alive_thread.join

        out.puts response
      end
    end

    def fetch_data
      Net::HTTP.get(URI("http://#{HOST}/stream/data"))
    end

    def fetch_response
      fetch_data
      # sleep 5 ; "tut"
    end
  end
end
