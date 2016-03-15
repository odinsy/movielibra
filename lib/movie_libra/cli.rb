#!/usr/bin/env ruby
require "thor"
require 'movie_libra/cli/fetch'
require 'movie_libra/cli/save'

module MovieLibra
  class Fetch < Thor
    desc "fetch TYPE FORMAT", "Fetch a new movies. Type can be imdb, tmdb."
    subcommand 'fetch', MovieLibra::CLI::Fetch
    desc "save TYPE FORMAT", "Save a new movies. Format can be json, csv."
    subcommand 'save', MovieLibra::CLI::Save
  end
end
