require "logger"
require "sinatra"
require "sinatra/base"

class ProtectedApp < Sinatra::Base
  set :protection,
      session: true,
      use: %i[authenticity_token],
      logger: Logger.new(STDOUT),
      reaction: :deny

  post "/" do
    pp params
    foo = (params[:foo] || '').strip

    body "tut #{foo.inspect} (#{foo.class})"
  end
end
