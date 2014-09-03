require 'sinatra/base'
require 'json'
require 'redis'


class App < Sinatra::Base

  ########################
  # Configuration
  ########################

  configure do
    enable :logging
    enable :method_override
    enable :sessions
    uri = URI.parse(ENV["REDISTOGO_URL"])
    $redis = Redis.new({
                    :host => uri.host,
                    :port => uri.port,
                    :password => uri.password
                    })
  end

  before do
    logger.info "Request Headers: #{headers}"
    logger.warn "Params: #{params}"
  end

  after do
    logger.info "Response Headers: #{response.headers}"
  end

  ########################
  # Routes
  ########################

  get('/') do
    @cheeses = []
    $redis.keys.each do |key|
    @cheeses << get_model_from_redis(key)
    end
    render(:erb, :"cheeses/index")
  end

  get('/cheeses/:id') do
    @cheese         = get_model_from_redis("cheeses:#{params[:id]}")
    @cheese["id"]   = "cheeses:#{params[:id]}"
    @cheese["show"] = true
    render(:erb, :"cheeses/show")
  end

  def get_model_from_redis(redis_id)
    model       = JSON.parse($redis.get(redis_id))
    model["id"] = redis_id
    model
  end

end
