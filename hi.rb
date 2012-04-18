require 'sinatra'
require 'awesome_print'

get '/' do
  ap request, :html => false

  body = ""
  headers = %w{request.env['HTTP_X_REAL_IP'] request.env['REMOTE_ADDR'] request.ip}
  body << "<pre>"
  headers.each do |header|
    body << "#{header}\t#{eval(header)}\n"
  end

  body << "\n"

  body << "</pre>"

  body
end

