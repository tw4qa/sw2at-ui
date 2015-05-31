module Crypto
  SEPARATOR = ':::'
  DATE_MASK = '%m-%d-%Y_%I-%M'

  def encrypt_namespace(opts)
    time = str_to_date(opts[:time])
    [ opts[:branch], date_to_str(time), opts[:user] ]*SEPARATOR
  end

  def decrypt_namespace(name)
    b, r, u = name.split(SEPARATOR)
    { branch: b, time: DateTime.strptime(r, DATE_MASK), user: u }
  end

  def date_to_str(time)
    time.is_a?(Date) ? time.strftime(DATE_MASK) : time
  end

  def str_to_date(time)
    time.is_a?(String) ? DateTime.parse(time, DATE_MASK) : time
  end

  def reformat_date(str)
    date_to_str(str_to_date(str))
  end

  extend self
end
