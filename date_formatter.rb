# Class Date Formatter
class DateFormatter
  FORMAT_LIST = %w[year month day hour minute second].freeze
  FORMAT_CONVERSION = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  }.freeze

  def initialize(format)
    @query = format
    @format = ''
    @query.split('-').each { |elem| @format += "#{FORMAT_CONVERSION[elem]}-" }
  end

  def result
    Time.now.strftime(@format).chop! + "\r\n"
  end

  def result_success?
    errors.empty?
  end

  def errors
    @query.split('-').reject { |e| FORMAT_LIST.include?(e) }
  end
end
