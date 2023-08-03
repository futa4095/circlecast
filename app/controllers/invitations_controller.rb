# frozen_string_literal: true

class InvitationsController < ApplicationController
  def show
    invitation = Invitation.find_by!(token: params[:token])
    session[:group_to_join] = invitation.group_id unless current_user.groups.exists?(invitation.group_id)
    redirect_to groups_path
  end
end
