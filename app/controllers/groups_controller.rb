# frozen_string_literal: true

class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit update destroy]

  def index
    @groups = Group.all
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
      redirect_to group_url(@group), notice: 'Group was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @group.update(group_params)
      redirect_to group_url(@group), notice: 'Group was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @group.destroy

    redirect_to groups_url, notice: 'Group was successfully destroyed.'
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :description)
  end
end
