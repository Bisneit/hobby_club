# frozen_string_literal: true

class GroupsController < ApplicationController
  def index
    result = if params[:my_groups]
                group_ids = current_user.participants.confirmed.pluck(:group_id)
                Group.where(id: group_ids)
              else
                Group.all
              end
    @groups = result.paginate(page: params[:page], per_page: 10)
  end

  def new
    @group = Group.new
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
    @group = Group.find(params[:id])
  end

  def create
    @group = Group.new(permitted_params)

    if @group.save
      data = YAML.load_file(Rails.root.join('db', 'data', 'default_roles.yml'))
      data.each do |role|
        @group.roles.create!(name: role['name'], description: role['description'])
      end

      @group.participants.create(user: current_user, status: :confirmed,
                                confirmed_at: Time.current, group_roles_id: @group.roles.find_by(name: 'Admin').id)

      if permitted_params[:avatar].blank?
        redirect_to groups_path
      else
        render :action => "crop"
      end
    else
      render 'new'
    end
  end

  def update
    @group = Group.find(params[:id])

    if @group.update_attributes(permitted_params)
      flash[:notice] = "Группа успешно обновлена"
      if permitted_params[:avatar].blank?
        redirect_to group_path(@group.id)
      else
        render :action => "crop"
      end
    end
  end

  private

  def permitted_params
    params.require(:group).permit(:name, :description, :avatar, :my_groups, :crop_x, :crop_y, :crop_w, :crop_h, :coef_w, :coef_h)
  end
end
