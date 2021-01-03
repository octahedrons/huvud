require "sinatra"
require "sinatra/base"

class TestApp < Sinatra::Base
  get "/*" do
    body "foo"
  end

  post "/*" do
    body "foo"
  end
end
