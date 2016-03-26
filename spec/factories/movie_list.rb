FactoryGirl.define do
  factory :movie_list, class: MovieLibra::MovieList do
    movies = File.expand_path("../data/movies.json", __FILE__)
    initialize_with { new(movies) }
  end
end
