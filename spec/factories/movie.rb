FactoryGirl.define do
  factory :movie do
    list { build(:movie_list) }
    attributes = ["http://www.imdb.com/title/tt0111161/", "The Shawshank Redemption", "1994", "USA", "1994-10-14", "Crime,Drama", "142", "9.3", "Frank Darabont", "Tim Robbins,Morgan Freeman,Bob Gunton"]
    initialize_with { new(list, attributes) }
  end
end
