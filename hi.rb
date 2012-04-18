require 'sinatra'

get '/hi' do
  "Hello World!"

  "<p>"

  "<ul>"
  "<li>"
  "request.env['HTTP_X_REAL_IP']: #{request.env['HTTP_X_REAL_IP']}"
  "</li>"
  "<li>"
  "request.env['HTTP_X_REAL_IP']: #{request.env['REMOTE_ADDR']}"
  "</li>"
  "<li>"
  "request.ip: #{request.ip}"
  "</li>"
  "<li>"
  "request.remote_ip: #{request.remote_ip}"

  "</ul>

end

