#!/usr/bin/env ruby

module Rate

  # Rate and make viewed movie
  def rate(num)
    unless (0..10).include?(num)
      raise ArgumentError, "You can rate film only from 0 to 10!"
    end
    @viewed     = true
    @date_movie = Date.today
    @my_rating  = num.to_i
  end

end
