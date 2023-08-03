# frozen_string_literal: true

class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: %i[show edit update destroy]

  def index
    @groups = current_user.groups.order(:id)
    return unless session[:group_to_join].present?

    unless current_user.memberships.exists?(group_id: session[:group_to_join])
      membership = current_user.memberships.create(group_id: session[:group_to_join])
      flash.now[:notice] = "#{membership.group.name}に加入しました"
    end
    session.delete :group_to_join
  end

  def show
    @episodes = @group.episodes.order(created_at: :desc)
  end

  def new
    @group = Group.new
  end

  def edit; end

  def create
    @group = Group.new(group_params)

    if @group.save
      current_user.memberships.create!(group_id: @group.id, admin: true)
      @group.create_invitation!(token: SecureRandom.urlsafe_base64)
      redirect_to group_url(@group), notice: 'グループを作成しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @group.update(group_params)
      redirect_to group_url(@group), notice: 'グループを更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @group.destroy

    redirect_to groups_url, notice: 'グループを削除しました'
  end

  private

  def set_group
    @group = current_user.groups.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :description, :icon)
  end
end
