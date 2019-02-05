# frozen_string_literal: true

class Groups::ParticipantsController < ApplicationController
  def index
    group_id = params[:group_id] || params[:q][:group_id]
    group = Group.find(group_id)
    @filters = group.participants.ransack(params[:q])
    @participants = @filters.result.paginate(page: params[:page], per_page: 10)
    render 'group_participants/index', locals: { group_id: group_id }
  end

  def show

  end

  def create
    user = User.find_by(id: params[:user_id])
    group = Group.find_by(id: params[:group_id])

    if user.participants.where(group: group).exists?
      flash[:notice] = "Вы уже вступили в эту группу"
    elsif user && group
      if group.public?
        group.participants.create(user: user, status: :confirmed, confirmed_at: Time.current)
        flash[:success] = "Вы успешно вступили в группу"
      else
        group.participants.create(user: user, status: :requested, confirmed_at: Time.current)
        flash[:success] = "Заявка в группу успешно отправлена"
      end
    else
      flash[:notice] = "Что то пошло не так"
    end

    redirect_back fallback_location: root_path
  end

  def destroy
    group = Group.find_by(id: params[:group_id])
    group.participants.where(user: current_user).delete_all
    flash[:success] = "Вы покинули группу"
    redirect_back fallback_location: root_path
  end
end
