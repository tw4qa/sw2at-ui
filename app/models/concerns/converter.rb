module Converter
  SEPARATOR = ':::'
  DATE_MASK = '%m-%d-%Y_%I-%M'

  # Revision namespace

  def encrypt_namespace(opts)
    time = str_to_date(opts[:time])
    [ opts[:branch], date_to_str(time), opts[:user] ]*SEPARATOR
  end

  def decrypt_namespace(name)
    b, r, u = name.split(SEPARATOR)
    { branch: b, time: DateTime.strptime(r, DATE_MASK), user: u }
  end

  # Dates

  def date_to_str(time)
    (time.is_a?(Date) || time.is_a?(Time)) ? time.strftime(DATE_MASK) : time
  end

  def str_to_date(time)
    time.is_a?(String) ? DateTime.parse(time, DATE_MASK) : time
  end

  def reformat_date(str)
    date_to_str(str_to_date(str))
  end

  # Array & single object conversions

  def time_value_str(time_value)
    if time_value.is_a?(Array)
      time_value.map{|tv| tv.is_a?(Date) ? date_to_str(tv) : tv }
    else
      date_to_str(time_value)
    end
  end

  def time_date_value(time_value)
    if time_value.is_a?(Array)
      time_value.map{|tv| str_to_date(tv) }
    else
      str_to_date(time_value)
    end
  end

  def symbol_value(time_value)
    if time_value.is_a?(Array)
      time_value.map &:to_sym
    else
      time_value.to_sym
    end
  end

  extend self
end
