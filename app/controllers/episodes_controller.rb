# frozen_string_literal: true

class EpisodesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_episode, only: %i[show edit update destroy]

  def index
    @episodes = Episode.all
  end

  def show; end

  def new
    @episode = Episode.new
  end

  def edit; end

  def create
    channel = current_user.channels.find(episode_params[:channel_id])
    @episode = channel.episodes.new(episode_params)

    if @episode.save
      redirect_to episode_url(@episode), notice: 'エピソードを作成しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @episode.update(episode_params)
      redirect_to episode_url(@episode), notice: 'エピソードを更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @episode.destroy

    respond_to do |format|
      format.html { redirect_to episodes_url, notice: 'Episode was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_episode
    @episode = current_user.episodes.find(params[:id])
  end

  def episode_params
    params.require(:episode).permit(:title, :description, :channel_id)
  end
end
