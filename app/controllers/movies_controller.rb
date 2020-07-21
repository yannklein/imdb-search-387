class MoviesController < ApplicationController
  def index
    if params[:query].present?
      # sql_query = " \
      #   movies.title @@ :query \
      #   OR movies.syllabus @@ :query \
      #   OR directors.first_name @@ :query \
      #   OR directors.last_name @@ :query \
      # "
      # @movies = Movie.joins(:director).where(sql_query, query: "%#{params[:query]}%")
      # @movies = Movie.global_search(params[:query])
      @movies = PgSearch.multisearch(params[:query]).map {|result| result.searchable }
    else
      @movies = Movie.all
    end
  end
end
