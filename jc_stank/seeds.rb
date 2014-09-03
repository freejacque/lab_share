require 'redis'
require 'json'
require 'pry'
require 'uri'

uri = URI.parse(ENV["REDISTOGO_URL"])
$redis = Redis.new({
                    :host => uri.host,
                    :port => uri.port,
                    :password => uri.password
                    })
$redis.flushdb

cheese_data = File.read("cheese_data.json")
cheese_data_parsed = JSON.parse(cheese_data)

cheese_data_parsed["cheese_data"].each_with_index do |cheese, index|
  $redis.set("cheeses:#{index}", cheese.to_json)
end


