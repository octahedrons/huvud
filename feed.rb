helpers do
  def feed
    feed = <<-EOF
<?xml version="1.0"?>
<rss version="2.0">
  <channel>
    <title>Example Channel</title>
    <link>http://example.com/</link>
    <description>My example channel</description>
    <item>
       <title>News for September the Second</title>
       <link>http://example.com/2002/09/01</link>
       <description>other things happened today</description>
    </item>
    <item>
       <title>News for September the First</title>
       <link>http://example.com/2002/09/02</link>
    </item>
  </channel>
</rss>
EOF
  end

  def protected!(user, pass)
    return if authorized?(user, pass)
    headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
    halt 401, "Not authorized\n"
  end

  def authorized?(user, pass)
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == [user, pass]
  end
end

get "/feed/:user/:pass" do |user, pass|
  protected!(user, pass)
  feed
end

get "/feed" do
  feed
end
