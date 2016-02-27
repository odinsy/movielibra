FactoryGirl.define do
  factory :movie do
    link "http://www.imdb.com/title/tt0111161/"
    name "The Shawshank Redemption"
    year "1994"
    country "USA"
    genre ["Crime","Drama"]
    date "1994-10-14"
    duration "142"
    rating "9.3"
    director "Frank Darabont"
    actors ["Tim Robbins","Morgan Freeman","Bob Gunton"]
  end
end
