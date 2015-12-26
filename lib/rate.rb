#!/usr/bin/env ruby

module Rate

  # Rate and make viewed movie
  def rate(num)
    unless (0..10).include?(num)
      raise ArgumentError, "You can rate film only from 0 to 10!"
    end
    @view_date  = Date.today
    @my_rating  = num.to_i
  end

  def next
    @movies.reject(&:viewed?).sort_by{ |m| [-m.rating * rand, m.class::WEIGHT * rand] }.first(5).each { |m| puts m.description }
  end

  def watched
    @movies.select(&:viewed?).sort_by{ |m| [-m.my_rating * rand, (Date.today - m.view_date).to_i * rand] }.first(5).each { |m| puts m.description }
  end

end
