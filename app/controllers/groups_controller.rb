# frozen_string_literal: true

class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: %i[show edit update destroy]

  def index
    @groups = current_user.groups.all
  end

  def show; end

  def new
    @group = Group.new
  end

  def edit; end

  def create
    @group = Group.new(group_params)

    if @group.save
      membership = current_user.memberships.new(group_id: @group.id, admin: true)
      membership.save!
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
