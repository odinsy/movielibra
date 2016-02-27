FactoryGirl.define do
  factory :my_movie_list do
    movies = [
      ["http://www.imdb.com/title/tt0111161/", "The Shawshank Redemption", "1994", "USA", "1994-10-14", "Crime,Drama", "142", "9.3", "Frank Darabont", "Tim Robbins,Morgan Freeman,Bob Gunton"],
      ["http://www.imdb.com/title/tt0068646/", "The Godfather", "1972", "USA", "1972-03-24", "Crime,Drama", "175", "9.2", "Francis Ford Coppola", "Marlon Brando,Al Pacino,James Caan"],
      ["http://www.imdb.com/title/tt0071562/", "The Godfather: Part II", "1974", "USA", "1974-12-20", "Crime,Drama", "202", "9.0", "Francis Ford Coppola", "Al Pacino,Robert De Niro,Robert Duvall"],
      ["http://www.imdb.com/title/tt0468569/", "The Dark Knight", "2008", "USA", "2008-07-18", "Action,Crime,Drama", "152", "9.0", "Christopher Nolan", "Christian Bale,Heath Ledger,Aaron Eckhart"]
    ]
    initialize_with { new(movies) }
  end
end
