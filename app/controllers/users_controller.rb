class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update]

  def index
    render json: User.all
  end

  def show
    render json: @user
  end

  def create
    @user = User.create(email: params[:email], password: params[:password])
    if @user
      render json: { msg: "Please Login" }, status: 200
    else
      render json: { error: "Incorrect email or password" }, status: 401
    end
  end

  def update
    if @user
      @user.update(password: params[:password])
      render json: { msg: "Password Updated!" }
    else
      render json: { msg: "There was an Error" }
    end
  end

  def delete

  end

  # private
  #
  # def user_params
  #   params.require(:user).permit(:email, :password)
  # end
  #
  # def set_user
  #   @user = User.find(params[:id])
  # end
end
