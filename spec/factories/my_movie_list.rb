FactoryGirl.define do
  factory :my_movie_list, class: MovieLibra::MyMovieList do
    movies = File.expand_path("../data/movies.json", __FILE__)
    initialize_with { new(movies) }
  end
end
