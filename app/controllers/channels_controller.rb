# frozen_string_literal: true

class ChannelsController < ApplicationController
  before_action :set_channel, only: %i[show edit update destroy]

  # GET /channels or /channels.json
  # def index
  #   @channels = Channel.all
  # end

  # GET /channels/1 or /channels/1.json
  def show; end

  # GET /channels/new
  def new
    @channel = Channel.new
  end

  # GET /channels/1/edit
  def edit; end

  # POST /channels or /channels.json
  def create
    @channel = Channel.new(channel_params)

    if @channel.save
      redirect_to channel_url(@channel), notice: '番組を作成しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /channels/1 or /channels/1.json
  def update
    if @channel.update(channel_params)
      redirect_to channel_url(@channel), notice: '番組を更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /channels/1 or /channels/1.json
  def destroy
    @channel.destroy

    redirect_to channels_url, notice: '番組を削除しました'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_channel
    @channel = Channel.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def channel_params
    params.require(:channel).permit(:title, :description, :group_id)
  end
end
