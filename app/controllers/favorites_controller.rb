class FavoritesController < ApplicationController

  def index
    render json: Favorite.all
  end
  #
  # def show
  #   render json: @user
  # end

  def create
    @favorite = Favorite.create(favorite_params)
    byebug
    if @favorite
      render json: @favorite
    else
      render json: { errors: @favorite.errors.full_messages }
    end
  end

  def delete
    @favorite = Favorite.find(params[:id])

    @favorite.destroy

  end

  private

  def favorite_params
    params.require(:favorite).permit(:user_id, :restaurant_id)
  end

end
