class MessagesController < ApplicationController
  # 常にmasterのログインを要求する
  before_action :authenticate_master!

  def index
    # 現在表示しているchannelの情報を取得する。viewではchannel名を表示させるために使う。
    @channel = Channel.find(params[:channel_id])
    # 現在表示しているteamの情報を取得する。viewではteam名を表示させるために使う。
    @team = Team.find(params[:team_id])
    # 現在表示しているteamに所属しているuserの情報を取得する。
    @user = User.find_by(master_id: current_master.id,team_id: params[:team_id])
    # 上で取得したuserが所属しているchannelを取得する。viewではこれらを一覧で表示する。
    @channels = @user.channels
    # 上で取得したchannelが持っているmessageを取得する。
    @channel_messages = @channel.messages
    # 入力されたmessageを受け取るため、インスタンスを作成する。
    @message = Message.new
  end

  def create #ここでの変数はviewでは使うことがないので、ローカル変数にする
    @user = User.find_by(master_id: current_master.id,team_id: params[:team_id])
    message = Message.new(create_params) #入力された値を保存する
    if message.save
      respond_to do |format|
        format.html { redirect_to team_channel_messages_path}
        format.json {
          render json: {
            message: message.text,
            name: message.user_name,
            image_url: message.image,
            datetime: message.created_at.strftime(' %I:%M %p')
          }
        } #入力されたデータを変数に入れてJSの部分に返す
      end
    else
      redirect_to team_channel_messages_path, alert: 'メッセージを入力してください'
    end
  end

  private
  def create_params
    params.require(:message).permit(:text, :image).merge(master_id: current_master.id, team_id: params[:team_id], channel_id: params[:channel_id], user_id: @user.id, user_name: @user.user_name)
  end
end
