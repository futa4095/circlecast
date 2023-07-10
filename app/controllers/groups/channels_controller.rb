# frozen_string_literal: true

module Groups
  class ChannelsController < ApplicationController
    before_action :authenticate_user!

    def index
      @group = current_user.groups.find(params[:group_id])
      @channels = @group.channels.all
    end
  end
end
