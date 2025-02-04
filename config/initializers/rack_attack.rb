module Rack
  class Attack
    Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

    # Allow all local traffic
    safelist('allow-localhost') do |req|
      req.ip == '127.0.0.1' || req.ip == '::1'
    end

    # Allow an IP address to make 15 requests every 5 seconds
    throttle('req/ip', limit: 15, period: 5, &:ip)
  end
end
