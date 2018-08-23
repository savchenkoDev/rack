# Test class for Rack
class App
  def call(env)
    perform_request
    [status, headers, body]
  end

  private

  def perform_request
    sleep rand(1..3)
  end

  def status
    200
  end

  end
  end
end
