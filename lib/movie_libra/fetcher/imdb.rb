#!/usr/bin/env ruby
# Parse information about movies from http://www.imdb.com/chart/top

require 'json'
require 'csv'
require 'mechanize'
require 'ruby-progressbar'
require 'pmap'
require 'movie_libra/export.rb'

module MovieLibra
  module Fetcher
    # Class which provides a posibility to parse movies information from IMDB
    # @example
    #   fetcher = MovieLibra::Fetcher::Imdb.new
    class Imdb
      include Export
      # URL to IMDB top-rated movies
      IMDB_URL = 'http://www.imdb.com/chart/top'.freeze

      attr_accessor :list

      # Creates a new MovieLibra::Fetcher::Imdb object
      # @attr [Array] list                   Array of movie hashes
      def initialize
        @list = []
      end

      # Parse movies information from IMDB to @list
      # @return [MovieLibra::Fetcher::Imdb] @list.count movies
      # @example
      #   fetcher = MovieLibra::Fetcher::Imdb.new
      #   fetcher.run!
      def run!
        bar = ProgressBar.create(total: movie_count)
        movie_links.peach(3) { |link| parse(link) && bar.increment }
        self
      end

      # Redefine method inspect
      # @return [MovieLibra::Fetcher::Imdb] @list.count movies
      def inspect
        "#{self.class} (#{@list.count} movies)"
      end

      private

      # Make movie link shorter
      # @return [String] Short IMDB movie link
      def shorten_link(link)
        link.split('/?').first
      end

      # Get movies links from http://www.imdb.com/chart/top
      # @return [Array] Array of movie links
      def movie_links
        agent = Mechanize.new
        page  = agent.get(IMDB_URL)
        page.links_with(css: 'td.titleColumn a').map { |link| shorten_link(page.uri.merge(link.href).to_s) }
      end

      # Get count of movies from http://www.imdb.com/chart/top
      # @return [Fixnum] Count of movies
      def movie_count
        agent = Mechanize.new
        page  = agent.get(IMDB_URL)
        page.links_with(css: 'td.titleColumn a').count
      end

      # Parse movie information to Hash and add him to [Array] @list
      # @return [Array] Array of movie hashes
      def parse(link)
        agent = Mechanize.new
        page  = agent.get(link)
        @list << {
          link:     page.canonical_uri.to_s,
          name:     page.search(".title_wrapper h1[itemprop='name']").text.gsub(/ \(\d+\)/, '').strip,
          year:     page.search('.title_wrapper h1 span#titleYear a').text,
          country:  page.links_with(href: %r{/country/}).map(&:text).first,
          date:     page.search("//*[@class='titleBar']//meta[@itemprop='datePublished']/@content").map(&:value).first,
          genre:    page.search(".see-more.inline.canwrap[itemprop='genre'] a").text.split(' ').map(&:strip),
          duration: page.search('.title_wrapper .subtext time/@datetime').first.value.gsub(/[^\d]/, ''),
          rating:   page.search('.imdbRating .ratingValue strong span').text,
          director: page.search(".credit_summary_item span[itemprop='director'] a").text,
          actors:   page.search(".credit_summary_item span[itemprop='actors'] a").map { |actor| actor.text.strip }
        }
      end
    end
  end
end
