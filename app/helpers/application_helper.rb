# frozen_string_literal: true

module ApplicationHelper
  def same_date(date1, date2)
    Date.parse(date1.to_s) == Date.parse(date2.to_s)
  end
end
