#!/usr/bin/env ruby
# Parse information about movies from http://www.imdb.com/chart/top

require 'json'
require 'csv'
require 'mechanize'
require 'progress_bar'
require 'pmap'
require 'movie_libra/export.rb'

module MovieLibra
  module Imdb

    class Fetcher

      include Export

      IMDB_URL = "http://www.imdb.com/chart/top"

      attr_accessor :list

      def initialize
        @list = []
      end

      def run!
        bar = ProgressBar.new(get_movie_count)
        get_movie_links.peach(4) { |link| parse(link) ; bar.increment! }
      end

      private

      def shorten_link(link)
        link.split("/?").first
      end

      def get_movie_links
        agent = Mechanize.new
        page  = agent.get(IMDB_URL)
        page.links_with(css: "td.titleColumn a").map { |link| shorten_link(page.uri.merge(link.href).to_s) }
      end

      def get_movie_count
        agent = Mechanize.new
        page  = agent.get(IMDB_URL)
        count = page.links_with(css: "td.titleColumn a").count
      end

      def parse(link)
        agent = Mechanize.new
        page  = agent.get(link)
        @list << {
          link:     page.canonical_uri.to_s,
          name:     page.search(".title_wrapper h1[itemprop='name']").text.gsub(/ \(\d+\)/,"").strip,
          year:     page.search(".title_wrapper h1 span#titleYear a").text,
          country:  page.links_with(href: %r{/country/}).map(&:text).first,
          date:     page.search("//*[@class='titleBar']//meta[@itemprop='datePublished']/@content").map(&:value).first,
          genre:    page.search(".see-more.inline.canwrap[itemprop='genre'] a").text.split("\s").map(&:strip),
          duration: page.search(".title_wrapper .subtext time/@datetime").first.value.gsub(/[^\d]/, ''),
          rating:   page.search(".imdbRating .ratingValue strong span").text,
          director: page.search(".credit_summary_item span[itemprop='director'] a").text,
          actors:   page.search(".credit_summary_item span[itemprop='actors'] a").map { |actor| actor.text.strip }
        }
      end

    end

  end
end
