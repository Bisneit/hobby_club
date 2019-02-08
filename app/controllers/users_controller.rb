# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(permitted_params)
    redirect_to user_path(user)
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def permitted_params
    params.require(:user).permit(:id, :first_name, :last_name, :phone, :email, :sex, :age, :city, :country)
  end
end
