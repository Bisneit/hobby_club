# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  private

  def permitted_params
    params.require(:user).permit(:id, :first_name, :last_name, :phone, :email)
  end
end
