class ChannelsController < ApplicationController

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

  private
  def channel_params
    # channelを作成するときにteam_idが必要なのでmergeする。
    params.require(:channel).permit(:name, { user_ids:[] }).merge(team_id: params[:team_id])
  end

end
