# frozen_string_literal: true

class GroupsController < ApplicationController
  def index
    @groups = Group.with_public_access
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(permitted_params)

    if @group.save 
      redirect_to groups_path
    else
      render 'new'
    end
  end

  private

  def permitted_params
    params.require(:group).permit(:name, :description, :avatar)
  end
end
