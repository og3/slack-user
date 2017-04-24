class DirectsController < ApplicationController
  # 常にmasterのログインを要求する
  before_action :authenticate_master!
  # before_action :set_direct, only:[:edit, :update, :destroy]

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
    if @direct.save
      # redirect先にteam_idとdirect_idを持っていく
       redirect_to team_direct_messages_path(params[:team_id], @direct.id), notice: 'Success to create direct!!'
    else
      flash.now[:alert] = "create error"
      render :new
    end
  end

  private
  def direct_params
    # directを作成するときにteam_idが必要なのでmergeする。
    params.require(:direct).permit({ user_ids:[] }).merge(team_id: params[:team_id])
  end

  # def set_direct
  #   # 表示するdirectのidを持ってくる。
  #    @direct = Direct.find(params[:id])
  # end
end
