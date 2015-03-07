Resque.configure do |config|
  config.redis = AppConfig.redis_url
end
