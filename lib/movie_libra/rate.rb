#!/usr/bin/env ruby

module MovieLibra
  class Movie
    module Rate
      # Rate and make viewed movie
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
