# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    # group = Group.find(params[:group_id])
    # @events = group.events
  end
end
