$stdout.sync = true
$stderr.sync = true

require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader'
require 'json'

require "pry-byebug"

require_relative '../lib/app_metadata'

if ENV["RACK_ENV"] == "development"
  get '/debug' do
    binding.pry
    "debugging"
  end
end

get '/ua' do
  body request.user_agent
end

get '/contact' do
  body "contact || #{env['HTTP_X_REAL_IP']} || #{Time.now} || #{Time.now.to_i}"
end

get '/customers' do
  body "customers || #{env['HTTP_X_REAL_IP']} || #{Time.now} || #{Time.now.to_i}"
end

get '/products' do
  #body "products || #{env['HTTP_X_REAL_IP']} || #{Time.now} || #{Time.now.to_i}"
  halt 403
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
  body << "<html><head>"
  body << %(<meta name="color-scheme" content="dark light">)
  body << "<title>huvud</title></head><body>"
  headers = %w{
    request.env['SERVER_PROTOCOL']
    request.env['HTTP_X_REAL_IP']
    request.env['REMOTE_ADDR']
    request.env["HTTP_X_FORWARDED_FOR"]
    request.ip
    env["HTTP_USER_AGENT"]
    env["HTTP_X_REAL_IP"]
    env["REMOTE_ADDR"]
    env["HTTP_X_FORWARDED_FOR"]
    env["QUERY_STRING"]
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
    request.base_url
    request.fullpath
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
  }
  body << "<p>This is #{AppMetadata.app_name} (#{AppMetadata.short_commit_link})</p>"
  body << "<a href=/foo>/foo</a>"
  body << "<table border=1>"
  headers.each do |header|
    body <<
      "<tr><td>#{header}</td>" <<
      "<td><pre>#{eval(header).class}</pre></td>" <<
      "<td>#{eval(header)}</td></tr>"
  end
  body << "</table>"

  body << "<p><code>request.env</code><p>"
  body << "<table border=1>"
  request.env.each do |header, value|
    puts "#{env['HTTP_X_REQUEST_ID']} #{header}: #{value}"
    body <<
      "<tr><td>#{header}</td>" <<
      "<td>#{value}</td></tr>"
  end
  body << "</table></body></html>"

  body
end

