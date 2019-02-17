# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @current_date = Date.today

    @param_date = params[:date].present? ? Date.parse(params[:date]) : @current_date
    @day = params[:day].present? ? Date.parse(params[:day]) : @current_date
    @group = Group.find(params[:group])
    start_at = @param_date.beginning_of_month.beginning_of_week(:monday)
    end_at = @param_date.end_of_month.end_of_week(:monday)
    keys = (start_at..end_at).map { |date| date }
    @events = keys.each_with_object({}) do |date, memo|
      memo[date.strftime('%y-%m-%d')] = {
        events: Event.where(group: @group).where('DATE(start_date) = ?', date.strftime('%d-%m-%y'))
      }
    end
  end
end
