#!/usr/bin/env ruby

module RateList
  # Rate and make viewed movie
  def rate(name, num)
    unless (0..10).include?(num)
      raise ArgumentError, "You can rate movie only from 0 to 10!"
    end
    movie           = find_movie(name)
    movie.my_rating = num.to_i
    movie.view_date = Date.today
  end
  # Get recommend movies with high rating for the review
  def recommend
    @movies.reject(&:viewed?).sort_by{ |m| [-m.rating * rand, m.class::WEIGHT * rand] }.first(5).each { |m| m.description }
  end
  # Get watched movies with high rating
  def watched
    @movies.select(&:viewed?).sort_by{ |m| [-m.my_rating * rand, (Date.today - m.view_date).to_i * rand] }.first(5).each { |m| m.description }
  end

end
