#!/usr/bin/env ruby

module RateList

  # Rate and make viewed movie
  def rate(name, num)
    movie             = find_movie(name)
    movie.viewed      = true
    movie.my_rating   = num
    movie.date_movie  = Date.today
  end

  def recommend
    @movies.reject(&:viewed?).sort_by{ |m| [-m.rating * rand, m.class::WEIGHT * rand] }.first(5).each { |m| puts m.description }
  end

  def watched
    @movies.select(&:viewed?).sort_by{ |m| [-m.my_rating * rand, (Date.today - m.view_date).to_i * rand] }.first(5).each { |m| puts m.description }
  end

end
