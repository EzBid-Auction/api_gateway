Rack::Attack.throttle("limit login per user", limit: 5, period: 1.hour) do |request|
  request.params["username"].to_s.downcase.gsub(/\s+/, "") if request.path == "/oauth/token" && request.post?
end

Rack::Attack.throttle("request by ip", limit: 10, period: 1.hour) do |request|
  request.ip
end

# limit_proc = proc { |req| req.env["REMOTE_USERS"] == "admin" ? 100 : 1 }
# period_proc = proc { |req| req.env["REMOTE_USERS"] == "admin" ? 1 : 60 }
#
# Rack::Attack.throttle("request per ip", limit: limit_proc, period: period_proc) do |request|
#   request.ip
# end

Rack::Attack.throttled_responder = lambda do |request|
  [ 503, {}, [ "Server Error\n" ] ]
end

Rack::Attack.blocklisted_responder = lambda do |request|
  [ 503, {}, [ "Blocked" ] ]
end
