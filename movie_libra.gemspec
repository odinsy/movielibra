# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'movie_libra/version'

Gem::Specification.new do |spec|
  spec.name          = "movie_libra"
  spec.version       = MovieLibra::VERSION
  spec.authors       = ["Oleg Dianov"]
  spec.email         = ["odidoit@gmail.com"]

  spec.summary       = %q{Ruby movie library for the working with the top-rated movies from IMDB and TMDB.}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/odinsy/movie_libra"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "http://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.1.4"

  spec.add_dependency "json"
  spec.add_dependency "mechanize"
  spec.add_dependency "ruby-progressbar"
  spec.add_dependency 'pmap'
  spec.add_dependency 'thor'

  spec.add_development_dependency "bundler", '~> 1.11', '>= 1.11.2' 
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec-core", "~> 3.0"
  spec.add_development_dependency 'factory_girl'
  spec.add_development_dependency 'fuubar'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'rubocop'

end
