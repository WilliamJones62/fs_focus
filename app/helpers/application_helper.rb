module ApplicationHelper
  def display_name(name)
    if name
      e = Employee.find_by(Badge_: name)
      formatted = e.Firstname + ' ' + e.Lastname
    else
      formatted = ' '
    end
  end
  def display_date(date)
    if date
      formatted = date.strftime("%Y %m %d")
    else
      formatted = ' '
    end
  end
end
