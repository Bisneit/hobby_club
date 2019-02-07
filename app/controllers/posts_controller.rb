# frozen_string_literal: true

class PostsController < ApplicationController
  def create
    byebug
    user = User.find(params[:user_id])
    user.profile_posts.create(author: current_user, body: params[:body])
  end
end
