class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
   
    if params[:sorting]
      session[:sorting]=params[:sorting]
    end
    
    if params[:ratings]
      session[:ratings]=params[:ratings]
    end
    
    if (params[:sorting]==nil && session[:sorting]!=nil) || (params[:ratings]==nil && session[:ratings]!=nil)
      params[:sorting]=session[:sorting]
      params[:ratings]=session[:ratings]
     redirect_to movies_path(params) 
    
    end
    
    @filter = session[:ratings]
    @sort=session[:sorting]
    if @sort!=nil && @filter!=nil
      @movies = Movie.where(:rating=>@filter.keys).order(@sort).all
    else if @sort!=nil
      @movies = Movie.order(@sort).all
      else if @filter!=nil
        @movies = Movie.where(:rating=>@filter.keys).all
      else
       @movies = Movie.all
       end
       end
    end
    if @filter==nil
      @filter=[]
    end
    #@all_ratings=['G', 'PG']
     @all_ratings = Movie.getRatings
     
     # @movies = Movie.all
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
