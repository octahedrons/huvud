require 'sinatra'
require 'sinatra/base'
require 'json'

get '/customers' do
  body "customers || #{request.ip} || #{Time.now} || #{Time.now.to_i}"
end

get '/products' do
  body "products || #{request.ip} || #{Time.now} || #{Time.now.to_i}"
end

get '/proto' do
  request.scheme
end

get '/params/:foo' do
  body = {
    "params[:foo]" => params[:foo],
    "params['foo']" => params['foo'],
    "params[:foo].to_s" => params[:foo].to_s,
  }
  json body
end

get '/dploy' do
  body 'hello'
end

get '/json' do
  json JSON.pretty_generate(request.env)
end

get '/204' do
  halt 204
end

get '/*' do
  body = ""
  headers = %w{
    request.env['HTTP_X_REAL_IP']
    request.env['REMOTE_ADDR']
    request.env["HTTP_X_FORWARDED_FOR"]
    request.ip
    env["HTTP_X_REAL_IP"]
    env["REMOTE_ADDR"]
    env["HTTP_X_FORWARDED_FOR"]
    request["HTTP_X_REAL_IP"]
    request["REMOTE_ADDR"]
    request["HTTP_X_FORWARDED_FOR"]
    request.host
    request.port
    request.accept
    request.body
    request.scheme
    request.script_name
    request.path_info
    request.port
    request.request_method
    request.query_string
    request.content_length
    request.media_type
    request.host
    request.get?
    request.form_data?
    request["SOME_HEADER"]
    request.referrer
    request.user_agent
    request.cookies
    request.xhr?
    request.url
    request.path
    request.ip
    request.secure?
    request.env
  }
  body << "<a href=/foo>/foo</a>"
  body << "<table border=1>"
  headers.each do |header|
    body <<
      "<tr><td>#{header}</td>" <<
      "<td><pre>#{eval(header).class}</pre></td>" <<
      "<td>#{eval(header)}</td></tr>"
  end
  body << "</table>"

  body
end

