#!/usr/bin/env ruby
require "thor"
require 'movie_libra/cli/fetch'

module MovieLibra
  class CLI < Thor
    desc "fetch TYPE FORMAT", "Fetch a new movies. Type can be imdb, tmdb. Formats: --json, --csv."
    subcommand 'fetch', MovieLibra::Fetch
  end
end
