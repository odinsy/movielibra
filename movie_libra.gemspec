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
  spec.executables   = ['libra']
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.1.4"

  spec.add_dependency "json", '~> 1.8', '>= 1.8.1'
  spec.add_dependency "mechanize", '~> 2.7', '>= 2.7.4'
  spec.add_dependency "ruby-progressbar", '~> 1.7', '>= 1.7.5'
  spec.add_dependency 'pmap', '~> 1.1', '>= 1.1.1'
  spec.add_dependency 'thor', '~> 0.19', '>= 0.19.1'

  spec.add_development_dependency "bundler", "~> 1.11.2"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec-core", "~> 3.0"
  spec.add_development_dependency 'factory_girl', '~> 4.7', '>= 4.7.0'
  spec.add_development_dependency 'fuubar', '~> 2.2', '>= 2.2.0'
  spec.add_development_dependency 'vcr', '~> 3.0', '>= 3.0.3'
  spec.add_development_dependency 'webmock', '~> 2.1', '2.1.0'
  spec.add_development_dependency 'rubocop', '~> 0.42', '>= 0.42.0'
end
