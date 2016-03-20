FactoryGirl.define do
  factory :my_movie_list, class: MovieLibra::MyMovieList do
    movies = [
      {link: "http://www.imdb.com/title/tt0111161/", name: "The Shawshank Redemption", year: "1994", country: "USA", date: "1994-10-14", genre: ["Crime","Drama"], duration: "142", rating: "9.3", director: "Frank Darabont", actors: ["Tim Robbins", "Morgan Freeman", "Bob Gunton"]},
      {link: "http://www.imdb.com/title/tt0017925/", name: "The General", year: "1926", country: "USA", date: "1929", genre: ["Action","Adventure","Comedy","Drama","War"], duration: "67", rating: "8.3", director: "Clyde BruckmanBuster Keaton", actors: ["Buster Keaton", "Marion Mack", "Glen Cavender"]},
      {link: "http://www.imdb.com/title/tt0052561/", name: "Anatomy of a Murder", year: "1959", country: "USA", date: "1959-09", genre: ["Crime","Drama","Mystery","Thriller"], duration: "160", rating: "8.1", director: "Otto Preminger", actors: ["James Stewart", "Lee Remick", "Ben Gazzara"]},
      {link: "http://www.imdb.com/title/tt0094625/", name: "Акира", year: "1988", country: "Japan", date: "1988-07-16", genre: ["Animation","Action","Sci-Fi"], duration: "124", rating: "8.1", director: "Katsuhiro Ôtomo", actors: ["Nozomu Sasaki","Mami Koyama","Mitsuo Iwata"]},
      {link: "http://www.imdb.com/title/tt0118694/", name: "In the Mood for Love", year: "2000", country: "Hong Kong", date: "2001-03-09", genre: ["Drama","Romance"], duration: "98", rating: "8.1", director: "Kar-wai Wong", actors: ["Tony Chiu Wai Leung","Maggie Cheung","Ping Lam Siu"]}
    ]
    initialize_with { new(movies) }
  end
end
