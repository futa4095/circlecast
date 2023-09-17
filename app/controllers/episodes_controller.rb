# frozen_string_literal: true

class EpisodesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_channel
  before_action :require_group_admin, only: %i[new create edit update destroy]
  before_action :set_episode, only: %i[show edit update destroy]

  def show; end

  def new
    @episode = @channel.episodes.new
  end

  def edit; end

  def create
    @episode = @channel.episodes.new(episode_params)

    if @episode.save
      redirect_to [@channel, @episode], notice: 'エピソードを作成しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @episode.update(episode_params)
      redirect_to [@channel, @episode], notice: 'エピソードを更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @episode.destroy
    redirect_to @channel, notice: 'エピソードを削除しました'
  end

  private

  def set_channel
    @channel = current_user.channels.find(params[:channel_id])
  end

  def set_episode
    @episode = @channel.episodes.find(params[:id])
  end

  def episode_params
    params.require(:episode).permit(:title, :description, :enclosure)
  end

  def require_group_admin
    return if @channel.group.admin? current_user

    redirect_back fallback_location: @channel, alert: 'この操作を行うには、グループ管理者である必要があります'
  end
end
