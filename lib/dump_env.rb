require "logger"
require "pp"
require "stringio"

class DumpEnv
  def initialize(app)
    @app = app
    @logger = Logger.new(STDERR, progname: self.class.name)
  end

  def call(env)
    @logger.info("env")
    @logger.info(dump(env))

    if env['rack.input'].respond_to?(:string)
      @logger.info("env['rack.input'].string")
      @logger.info(dump(env['rack.input'].string))
    else
      @logger.info("env['rack.input'] doesn't respond to #string, is a: #{env['rack.input'].inspect}")
    end

    @logger.info("Request.new(env).params")
    @logger.info(dump(Rack::Request.new(env).params))

    @app.call(env)
  end

  private

  def dump(obj)
    out = StringIO.new
    PP.pp(obj, out)
    out.string
  end
end
