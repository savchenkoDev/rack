# Test class for Rack
class App
  DEFAULT_HEADERS = { 'Content-Type' => 'text/plain' }.freeze

  def call(env)
    request = Rack::Request.new(env)

    if request.path_info == '/time'
      return error_400(@errors) unless errors_check(request[:format]).empty?
      success(request[:format])
    else
      error_404(request.path_info)
    end
  end

  private

  def error_404(url)
    [404, DEFAULT_HEADERS, ["URL \"#{url}\" NOT FOUND\r\n"]]
  end

  def error_400(errors)
    [400, DEFAULT_HEADERS, ["UNKNOWN FORMAT #{errors}\r\n"]]
  end

  def success(format)
    [200, DEFAULT_HEADERS, [DateFormatter.new(format).call]]
  end

  def errors_check(format)
    @errors = format.split('-').reject { |e| DateFormatter::FORMAT_LIST.include?(e) }
  end
end
