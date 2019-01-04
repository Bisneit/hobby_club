# frozen_string_literal: true

class GroupParticipantsController < ApplicationController
  def index
    group_id = params[:group_id] || params[:q][:group_id]
    group = Group.find(group_id)
    @filters = group.participants.ransack(params[:q])
    @participants = @filters.result.paginate(page: params[:page], per_page: 10)
    render 'group_participants/index', locals: { group_id: group_id }
  end

  def create
    user = User.find_by(id: params[:user_id])
    group = Group.find_by(id: params[:group_id])
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

  def destroy
    group = Group.find_by(id: params[:id])
    group.participants.where(user: current_user).delete_all
    redirect_to group_path(group.id)
  end
end
