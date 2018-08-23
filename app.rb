# Test class for Rack
class App
  FORMAT_LIST = %w[year month day hour minute second].freeze
  DEFAULT_HEADERS = { 'Content-Type' => 'text/plain' }.freeze
  FORMAT_CONVERSION = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  }.freeze
  STATUS_SUCCESS = 200
  STATUS_UNKNOWN_FORMAT = 400
  STATUS_UNKNOWN_PATH = 404

  def call(env)
    clear_query = env['QUERY_STRING'].sub('format=', '')
    if env['REQUEST_PATH'] != '/time'
      body = ["URL NOT FOUND\r\n"]
      status = STATUS_UNKNOWN_PATH
    elsif format_check(clear_query).empty?
      body = answer(clear_query)
      status = STATUS_SUCCESS
    else
      body = ["Unknown format #{@errors}\r\n"]
      status = STATUS_UNKNOWN_FORMAT
    end
    send_answer(status, body)
  end

  private

  def format_check(string)
    @errors = string.split('-').reject { |e| FORMAT_LIST.include?(e) }
  end

  def answer(query)
    format = ''
    query.split('-').each { |elem| format += FORMAT_CONVERSION[elem] + '-' }
    time = Time.now.strftime(format).chop!
    [time + "\r\n"]
  end

  def send_answer(status, body, headers = DEFAULT_HEADERS)
    [status, headers, body]
  end
end
