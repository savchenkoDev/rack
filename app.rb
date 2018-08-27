# Test class for Rack
class App
  DEFAULT_HEADERS = { 'Content-Type' => 'text/plain' }.freeze

  def call(env)
    request = Rack::Request.new(env)

    case request.path_info
    when '/time'
      formatter = DateFormatter.new(request[:format])
      if formatter.result_success?
        time_response(formatter)
      else
        unknown_format_response(formatter.errors)
      end
    else
      unknown_url_response(request.path_info)
    end
  end

  private

  def unknown_url_response(url)
    [404, DEFAULT_HEADERS, ["URL \"#{url}\" NOT FOUND\r\n"]]
  end

  def unknown_format_response(errors)
    [400, DEFAULT_HEADERS, ["UNKNOWN FORMAT #{errors}\r\n"]]
  end

  def time_response(formatter)
    [200, DEFAULT_HEADERS, [formatter.result]]
  end
end
