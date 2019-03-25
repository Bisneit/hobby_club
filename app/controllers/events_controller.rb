# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :authenticate_user!

  def new
    @group = Group.find(params[:group])
    if @group.participants.where(group: @group, user: current_user).blank?
      flash[:notice] = 'Вы не можете создавать события для этой группы'
      redirect_back fallback_location: root_path
      return
    else
      @event = Event.new
    end
  end

  def create
    result = Events::CreateValidator.new(permitted_params).call
    if result == 'success'
      repeat_params[:type] == 'no' ? create_single_event : create_repeatable_event
      redirect_back fallback_location: root_path
    else
      flash[:notice] = result
      redirect_to new_event_path(group: Group.find(event_params[:group_id]))
    end
  end

  def index
    if params[:type] == 'list'
      if params[:group].blank?
        redirect_to root_path
      else
        @group = Group.find(params[:group])
        if @group.participants.where(group: @group, user: current_user).blank?
          flash[:notice] = 'Вы не можете просматривать события этой группы'
          redirect_back fallback_location: root_path
          return
        else
          @events = @group.events.paginate(page: params[:page], per_page: 10).order(start_at: :desc)
          render 'events/_list'
        end
      end
    else
      @current_date = Date.today
      @param_date = params[:date].present? ? Date.parse(params[:date]) : @current_date
      @day = params[:day].present? ? Date.parse(params[:day]) : @current_date
      if params[:group].blank?
        redirect_to root_path
      else
        @group = Group.find(params[:group])
        if @group.participants.where(group: @group, user: current_user).blank?
          flash[:notice] = 'Вы не можете просматривать события этой группы'
          redirect_back fallback_location: root_path
          return
        else
          start_at = @param_date.beginning_of_month.beginning_of_week(:monday)
          end_at = @param_date.end_of_month.end_of_week(:monday)
          keys = (start_at..end_at).map { |date| date }
          @events = keys.each_with_object({}) do |date, memo|
            memo[date.strftime('%y-%m-%d')] = {
              events: @group.events.where('DATE(date) = ?', date.strftime('%d-%m-%y'))
            }
          end
        end

        render 'events/_calendar'
      end
    end
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    redirect_back fallback_location: root_path
  end

  private

  def create_single_event
    Event.create(event_params)
    flash[:success] = "Событие создано"
  end

  def create_repeatable_event
    events = []
    @event = Event.create(event_params)
    events << @event
    created_events = 1
    last_date = Date.parse(event_params[:date])
    while created_events <= (repeat_params[:repeat_number].to_i - 1) do
      last_date += 1.day
      if repeat_params[:days].include?(last_date.wday.to_s)
        created_events +=1
        @event = Event.new
        @event.assign_attributes(event_params)
        @event.date = last_date
        @event.save
        events << @event
      end
    end
    flash[:success] = "Событий создано: #{created_events}"
  end

  def permitted_params
    params.require(:event).permit(:description, :date, :start_at, :end_at, :group_id,:type, :repeat_number, :without_weekends, :page, days: [])
  end

  def event_params
    permitted_params.slice(:description, :date, :start_at, :end_at, :group_id)
  end

  def repeat_params
    permitted_params.slice(:type, :repeat_number, :without_weekends, :days)
  end
end
