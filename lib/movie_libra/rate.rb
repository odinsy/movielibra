#!/usr/bin/env ruby

module MovieLibra
  class Movie
    # Module which provides a functionality for rate watched movie
    module Rate
      # Rate and make viewed movie
      # @param [Date] date    Date movie
      # @param [Fixnum] num   Your movie rating
      def rate(date, num)
        unless (0..10).cover?(num)
          raise ArgumentError, 'You can rate movie only from 0 to 10!'
        end
        @view_date  = date
        @my_rating  = num.to_i
      end
    end
  end
end
