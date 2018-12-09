# frozen_string_literal: true

class GroupParticipantsController < ApplicationController
  def index
    group = Group.find(permitted_params[:group_id])
    @participants = group.participants
  end

  def create
    user = User.find_by(id: permitted_params[:user_id])
    group = Group.find_by(id: permitted_params[:group_id])
    if user.participants.where(group: group).exists?
      flash[:notice] = "Вы уже вступили в эту группу"
    elsif user && group
      GroupParticipant.create(group: group, user: user)
      flash[:success] = "Вы успешно вступили в группу"
    else
      flash[:notice] = "Что то пошло не так"
    end
    redirect_to group_path(group.id)
  end

  private

  def permitted_params
    params.permit(:user_id, :group_id)
  end
end
