class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    # define the @movies to be displayed as either all, or sorted when :order symbol is passed
    @movies = Movie.find(:all, :order => params[:sort])

    # defines an enumerable collection of all possible values of a movie rating
    @all_ratings = Movie.all_ratings
    unless params[:ratings].nil?
      @checked_ratings = params[:ratings].keys
      @movies = Movie.find(:all, :order => params[:sort]).select { |m| @checked_ratings.include?(m.rating) }
    end  

  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
