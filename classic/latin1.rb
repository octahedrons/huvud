# encoding: iso-8859-1

require "sinatra"
require "sinatra/base"
require "json"

get "/latin1" do
  headers "Content-Type" => "text/html; charset=iso-8859-1"
  doc = "<html><head><title>åäö foo</title></head><body>åäö bar</body></html>"
  body doc
end
