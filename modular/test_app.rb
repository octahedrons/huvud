require "sinatra"
require "sinatra/base"

class TestApp < Sinatra::Base
  post "/" do
    pp params
    foo = (params[:foo] || '').strip

    body "tut #{foo.inspect} (#{foo.class})"
  end
end
