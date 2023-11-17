# frozen_string_literal: true

class ChannelsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: %i[index new edit update create destroy]
  before_action :require_group_admin, only: %i[new create edit update destroy]
  before_action :set_channel, only: %i[show edit update destroy]

  def index
    @channels = @group.channels.with_attached_artwork.order(:id).page(params[:page])
  end

  def show
    @episodes = @channel.episodes.order(created_at: :desc).page(params[:page])
  end

  def new
    @channel = @group.channels.new
  end

  def edit; end

  def create
    @channel = @group.channels.new(channel_params)

    if @channel.save
      redirect_to channel_url(@channel), notice: '番組を作成しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @channel.update(channel_params)
      redirect_to channel_url(@channel), notice: '番組を更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @channel.destroy
    redirect_to group_channels_url(@group), notice: '番組を削除しました'
  end

  private

  def set_group
    @group = current_user.groups.find(params[:group_id])
  end

  def set_channel
    @channel = current_user.channels.find(params[:id])
  end

  def channel_params
    params.require(:channel).permit(:title, :description, :artwork)
  end

  def require_group_admin
    return if @group.admin? current_user

    redirect_back fallback_location: @group, alert: 'この操作を行うには、グループ管理者である必要があります'
  end
end
