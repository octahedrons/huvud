require "logger"
require "pp"
require "stringio"

class DumpEnv
  def initialize(app)
    @app = app
    @logger = Logger.new(STDERR, progname: self.class.name)
  end

  def call(env)
    out = StringIO.new
    PP.pp(env, out)
    @logger.info(out.string)

    @app.call(env)
  end
end
