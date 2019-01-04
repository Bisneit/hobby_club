# frozen_string_literal: true

class GroupsController < ApplicationController
  def index
    result = if params[:my_groups]
                group_ids = current_user.participants.pluck(:group_id)
                Group.where(id: group_ids)
              else
                Group.with_public_access
              end
    @groups = result.paginate(page: params[:page], per_page: 10)
  end

  def new
    @group = Group.new
  end

  def show
    @group = Group.find(params[:id])
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
    params.require(:group).permit(:name, :description, :avatar, :my_groups)
  end
end
