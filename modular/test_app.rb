require "sinatra"
require "sinatra/base"

class TestApp < Sinatra::Base
  get "/*" do
    body "foo"
  end

  post "/*" do
    token = params["authenticity_token"]
    pp token.inspect
    # Base64.strict_decode64(token)

    body "foo"
  end
end
