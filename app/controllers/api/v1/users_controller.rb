  
class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
      @users = User.all 
      render json: UserSerializer.new(@users).serialized_json
  end

  def show
      render json: UserSerializer.new(@user).serialized_json
  end

  def create
      @user = User.new(user_params)
      if @user.save
          session[:user_id] = @user.id
          render json: UserSerializer.new(@user), status: :created, status: :created
      else
          resp = {
              error: @user.errors.full_messages.to_sentence
          }
          render json: resp, status: :unprocessable_entity
      end
  end

  def update
      if @user.update(user_params)
          render json: @user
      else
          render json: @user.errors, status: :unprocessable_entity
      end
  end

  def destroy
      @user.destroy
  end

private

  def set_user
      @user = User.find_by(id: params[:id])
  end

  def user_params
      params.require(:user).permit(:name, :email, :password)
  end
end