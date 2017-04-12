class ChannelsController < ApplicationController

  before_action :set_channel, only:[:edit, :update, :destroy]

  def new
    @channel = Channel.new
  end

  def create
    # ログインしているmasterのidと、現在表示しているteamのidを持つuserを探してくる。
    @user = User.where(master_id: current_master.id,team_id: params[:team_id])
    # 入力されたnameと追加されたuserのidをインスタンスにいれる。
    @channel = Channel.new(channel_params)
    # channelを作成したuserをchannelに入れる。
    @channel.users << @user
    if @channel.save
      # redirect先にteam_idとchannel_idを持っていく
       redirect_to team_channel_messages_path(params[:team_id], @channel.id), notice: 'Success to create channel!!'
    else
      flash.now[:alert] = "Input channel name!!"
      render :new
    end
  end

  def edit
  end

  def update
     @user = User.where(master_id: current_master.id,team_id: params[:team_id])
     @channel.users << @user
    if @channel.update(channel_params)
      redirect_to team_channel_messages_path(params[:team_id], @channel.id), notice: 'Success to edit channel!!'
    else
      flash[:alert] = 'Fail to update channel'
      render :edit
    end
  end

  def destroy
    # channelを削除する。
    @channel.destroy
    # teamのshowに飛ばすために現在のteam_idを取得。
    @team = Team.find(params[:team_id])
    redirect_to team_path(@team.id), notice: 'Success to delete channel!!'
  end

  private
  def channel_params
    # channelを作成するときにteam_idが必要なのでmergeする。
    params.require(:channel).permit(:name, { user_ids:[] }).merge(team_id: params[:team_id])
  end

  def set_channel
    # 表示するchannelのidを持ってくる。
     @channel = Channel.find(params[:id])
  end

end
