# frozen_string_literal: true

class FollowersController < ApplicationController
  def create
    Follower.create(follower: current_user, followed_id: params[:user_id])
    redirect_back fallback_location: root_path
  end

  def destroy
    follower = Follower.find(params[:id])
    follower.delete
    redirect_back fallback_location: root_path
  end
end
