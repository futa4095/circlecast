# frozen_string_literal: true

module Groups
  class MembersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_group

    def index
      @memberships = @group.memberships.order(admin: :desc, id: :asc)
    end

    def update
      if self_leave?
        @group.leave_member current_user
        redirect_to groups_path, notice: "#{@group.name}から脱退しました"
      else
        @membership = @group.memberships.find_by!(user_id: params[:id])
        @membership.update!(membership_params)
      end
    end

    private

    def set_group
      @group = current_user.groups.find(params[:group_id])
    end

    def membership_params
      params.require(:membership).permit(:id, :admin, :withdrawal)
    end

    def self_leave?
      current_user.id == params[:id].to_i && membership_params[:withdrawal] == 'true'
    end
  end
end
