FactoryGirl.define do
  factory :tmdb_fetcher, class: MovieLibra::Fetcher::Tmdb do
    key "dd165b18174b238eb2af5a0c3552f2f3"
    initialize_with { new(key) }
  end
end
