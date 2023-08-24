# frozen_string_literal: true

module Groups
  class MembersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_group

    def index
      @memberships = @group.memberships.order(admin: :desc, id: :asc)
    end

    def update
      @membership = @group.memberships.find_by!(user_id: params[:id])
      @membership.update!(membership_params)
    end

    private

    def set_group
      @group = current_user.groups.find(params[:group_id])
    end

    def membership_params
      params.require(:membership).permit(:id, :admin, :withdrawal)
    end
  end
end
