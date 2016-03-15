#!/usr/bin/env ruby
require "thor"
require 'movie_libra/export'

module MovieLibra
  module CLI
    class Save < Thor
      desc "imdb", "Fetch the imdb movies."
      def json
        @fetcher.save_to_json
      end

      desc "tmdb", "Fetch the tmdb movies."
      def csv
        @fetcher.save_to_csv
      end
    end
  end
end
