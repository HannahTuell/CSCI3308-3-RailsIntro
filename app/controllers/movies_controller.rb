class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    if(params[:sort] && session[:sort] && params[:ratings] && session[:ratings] == nil)
      @movies = Movie.all
    end
    # initialize an instance variable 'redirect' as false (or zero)
    @redirect = 0  
    # defines an enumerable collection of all possible values of a movie rating
    @all_ratings = Movie.all_ratings

    # 
    if(params[:sort] == 'title')
      session[:sort] = params[:sort]
      @movies = Movie.find(:all, :order =>params[:sort])
    elsif(params[:sort] == 'release_date')
      session[:sort] = params[:sort]
      @movies = Movie.find(:all, :order =>params[:sort])
    elsif(session.has_key?(:sort) )
      params[:sort] = session[:sort]
      @redirect = 1
    end

    if(params[:ratings] != nil)
      session[:ratings] = params[:ratings]
      @checked_ratings = params[:ratings].keys
      @movies = Movie.find(:all, :order => params[:sort]).select { |m| @checked_ratings.include?(m.rating) }
    elsif(session.has_key?(:ratings) )
      params[:ratings] = session[:ratings]
      @redirect =1
    end
    
    if(@redirect ==1)
      flash.keep
      redirect_to movies_path(:sort=>params[:sort], :ratings =>params[:ratings] )
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
