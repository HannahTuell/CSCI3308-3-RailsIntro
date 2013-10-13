class Movie < ActiveRecord::Base
  @all_ratings = ['G', 'PG', 'PG-13', 'R']
  
 # method on a movie that allows us to interact with the movie's ratings
  def self.all_ratings
    @all_ratings
  end
end
