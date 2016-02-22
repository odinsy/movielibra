#!/usr/bin/env ruby
# Parse information about movies from IMDb TOP250

require 'json'
require 'mechanize'

class Parser

  IMDB_URL = "http://www.imdb.com/chart/top"

  def self.parse
    agent = Mechanize.new
    page  = agent.get(IMDB_URL)
    page.links_with(css: "td.titleColumn a").map do |link|
      mov             = {}
      review          = link.click
      mov[:link]      = review.canonical_uri
      mov[:name]      = review.search(".title_wrapper h1[itemprop='name']").text.gsub(/\(\d+\)/,"").strip
      mov[:year]      = review.search(".title_wrapper h1 span#titleYear a").text
      mov[:country]   = review.links_with(href: %r{/country/})
      mov[:date]      = review.search("//meta[@itemprop='datePublished']/@content").map(&:value)
      mov[:genre]     = review.search(".see-more.inline.canwrap[itemprop='genre'] a").text.split("\s").map(&:strip)
      mov[:duration]  = review.search("#titleDetails.article .txt-block time[itemprop='duration']").first.text
      mov[:rating]    = review.search(".imdbRating .ratingValue strong span").text
      mov[:director]  = review.search(".credit_summary_item span[itemprop='director'] a").text
      mov[:actors]    = review.search(".credit_summary_item span[itemprop='actors'] a").map { |actor| actor.text.strip }
      mov
    end
  end

end
