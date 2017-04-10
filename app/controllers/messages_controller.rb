class MessagesController < ApplicationController
  def index
    # 現在表示しているchannelの情報を取得する。viewではchannel名を表示させるために使う。
    @channel = Channel.find(params[:channel_id])
    # 現在表示しているteamの情報を取得する。viewではteam名を表示させるために使う。
    @team = Team.find(params[:team_id])
    # 現在表示しているteamに所属しているuserの情報を取得する。
    @user = User.find_by(master_id: current_master.id,team_id: params[:team_id])
    # 上で取得したuserが所属しているchannelを取得する。viewではこれらを一覧で表示する。
    @channels = @user.channels
  end
end
