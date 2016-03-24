#!/usr/bin/env ruby

module MovieLibra
  class MovieList
    # Module which provides a functionality for:
    # * rate watched movie
    # * get list of recommended (not-watched) movies
    # * get list of watched highest-rated movies
    module RateList
      # Rate and make viewed movie
      # @param [String] name  Movie name that you want to rate
      # @param [Fixnum] num   Your movie rating
      def rate(name, num)
        unless (0..10).cover?(num)
          raise ArgumentError, 'You can rate movie only from 0 to 10!'
        end
        movie           = find_movie(name)
        movie.my_rating = num.to_i
        movie.view_date = Date.today
      end

      # Get list of recommended movies with high rating to watch
      # @return [Array] 5 unwatched highest-rated movies
      def recommend
        @movies.reject(&:viewed?).sort_by { |m| [-m.rating * rand, m.class::WEIGHT * rand] }.first(5).each(&:description)
      end

      # Get list of watched movies that you appreciated
      # @return [Array] 5 watched highest-rated movies
      def watched
        @movies.select(&:viewed?).sort_by { |m| [-m.my_rating * rand, (Date.today - m.view_date).to_i * rand] }.first(5).each(&:description)
      end
    end
  end
end
