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
    @format = ''
    format.split('-').each { |elem| @format += FORMAT_CONVERSION[elem] + '-' }
  end

  def call
    Time.now.strftime(@format).chop! + "\r\n"
  end
end
