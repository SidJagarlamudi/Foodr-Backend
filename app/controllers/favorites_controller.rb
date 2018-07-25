class FavoritesController < ApplicationController

  def index
    render json: Favorite.all
  end
  #
  # def show
  #   render json: @user
  # end

  def create
    if logged_in
      spot = Business.find(params[:business_id])
      user = current_log
      @favorite = Favorite.create(spot: spot, user: user)
      # byebug
      if @favorite
        render json: user.spots
      else
        render json: { errors: @favorite.errors.full_messages }
      end
    else
      render json: { errors: "User not logged in" }
    end
  end

  def delete
    @favorite = Favorite.find(params[:id])

    @favorite.destroy

  end

  private

  # def favorite_params
  #   params.require(:favorite).permit(:user_id, :business_id)
  # end

end
