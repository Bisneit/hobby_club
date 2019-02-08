# frozen_string_literal: true

class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    user = User.find(params[:user_id])
    user.profile_posts.create(author: current_user, body: params[:body])
    redirect_back fallback_location: root_path
  end

  def destroy
    post = Post.find(params[:id])
    post.delete
    redirect_back fallback_location: root_path
  end
end
