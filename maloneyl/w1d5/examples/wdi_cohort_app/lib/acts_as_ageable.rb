require 'date'

module ActsAsAgeable
  
  DATE_FORMAT = '%d/%m/%Y'
  
  def ActsAsAgeable.parse_date_string(str)
    Date.strptime(str, DATE_FORMAT)
  end
  
  def age
    temp_age  = now.year - dob.year
    temp_age -= 1 unless had_birthday_this_year?
    temp_age
  end
  
  def birthday_today?
    dob.day == now.day && dob.month == now.month
  end
  
  def had_birthday_this_year?
    (now.month > dob.month) || (now.month == dob.month && now.day >= dob.day)
  end
  
  private
  
  def now
    Time.now.utc.to_date
  end
  
end