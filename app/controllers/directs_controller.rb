class DirectsController < ApplicationController
  # 常にmasterのログインを要求する
  before_action :authenticate_master!
  before_action :set_direct, only:[:edit, :update, :destroy]

  def new
    @direct = Direct.new
  end

  def create
    # ログインしているmasterのidと、現在表示しているteamのidを持つuserを探してくる。
    @user = User.where(master_id: current_master.id,team_id: params[:team_id])
    # 入力されたnameと追加されたuserのidをインスタンスにいれる。
    @direct = Direct.new(direct_params)
    # directを作成したuserをdirectに入れる。
    @direct.users << @user
    # binding.pry
    if @direct.save
      # redirect先にteam_idとdirect_idを持っていく
       redirect_to team_direct_messages_path(params[:team_id], @direct.id), notice: 'Success to create direct!!'
    else
      flash.now[:alert] = "create error"
      render :new
    end
  end

  def edit
    @users = @direct.users
  end

  def update
    if @direct.update(direct_params)
      # directにmasterのuserが属していない場合、team一覧にリダイレクトする。
      if (@direct.users & current_master.users).empty?
        redirect_to team_path(params[:team_id]), notice: 'you left channel'
      else
        redirect_to team_direct_messages_path(params[:team_id], @direct.id), notice: 'Success to edit channel!!'
      end
    else
      flash[:alert] = 'Fail to update channel'
      render :edit
    end
  end

  def index
    @user = User.where(master_id: current_master.id,team_id: params[:team_id])
    # @userが持っている全てのdirectを取得する。
    # 現在エラー発生！！nomethodエラー
    @directs = @user.directs
  end

  def destroy
    # channelを削除する。
    @direct.destroy
    # teamのshowに飛ばすために現在のteam_idを取得。
    @team = Team.find(params[:team_id])
    redirect_to team_path(@team.id), notice: 'Success to delete channel!!'
  end

  private
  def direct_params
    # directを作成するときにteam_idが必要なのでmergeする。
    params.require(:direct).permit({ user_ids:[] }).merge(team_id: params[:team_id])
  end

  def set_direct
    # 表示するdirectのidを持ってくる。
     @direct = Direct.find(params[:id])
  end
end
