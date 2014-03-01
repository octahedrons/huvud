require 'sinatra'
require 'sinatra/base'

get '/*' do
  #ap request, :html => false

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
  body << "<table border=1>"
  headers.each do |header|
    body << "<tr><td>#{header}</td><td><pre>#{eval(header).class}</pre></td><td>#{eval(header)}</td></tr>"
  end
  body << "</table>"

  body
end

