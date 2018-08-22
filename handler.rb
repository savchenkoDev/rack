require 'rack'

app = proc do |env|
  [
    200,
    { 'Content-Type' => 'text/plain' },
    ["Hello Rack!\n"]
  ]
end

Rack::Handler::WEBrick.run app
