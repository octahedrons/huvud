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

    log "Request.new(env).params", Rack::Request.new(env).params
    log "env['rack.request.form_vars']", env['rack.request.form_vars']
    log "env['rack.request.form_hash']", env['rack.request.form_hash']
    log "env['rack.request.form_input'].string", env['rack.request.form_input'].string

    @app.call(env)
  end

  private

  def log(desc, obj)
    @logger.info(desc)
    @logger.info(dump(obj))
  end

  def dump(obj)
    out = StringIO.new
    PP.pp(obj, out)
    out.string
  end
end
