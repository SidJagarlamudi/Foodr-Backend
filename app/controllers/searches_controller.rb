class SearchesController < ApplicationController

  def index
    render json: Search.all
  end

  def show
    @search = Search.find(params[:id])
    render json: @search.businesses
  end

  def create
    if logged_in
      user = current_log
      @search = Search.create(term: params[:term], user: user)
      if @search
        # if params[:latitude]
        #   results = @search.search(params[:term])
        # else
          results = @search.search(params[:term], params[:latitude], params[:longitude])
        # end
        render json: @search.businesses
      else
        render json: { errors: @search.errors.full_messages }
      end
    else
      render json: { errors: "User not logged in" }
    end
  end

end
