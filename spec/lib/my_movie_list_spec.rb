require 'movie_libra/movie_list'
require 'movie_libra/my_movie_list'

describe "MyMovieList" do
  let!(:movies) { build(:my_movie_list) }
  let!(:movie) { build(:movie) }
  context "when called method find_movie" do
    it "returns the movie if exists" do
      expect(movies.find_movie("The Shawshank Redemption").name).to eq(movie.name)
    end
    it "returns nil if doesn't exist" do
      expect(movies.find_movie("blabla")).to eq(nil)
    end
  end
end
