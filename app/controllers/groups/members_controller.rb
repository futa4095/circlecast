# frozen_string_literal: true

module Groups
  class MembersController < ApplicationController
    before_action :authenticate_user!

    def index
      @group = current_user.groups.find(params[:group_id])
      @memberships = @group.memberships.order(admin: :desc)
    end
  end
end
