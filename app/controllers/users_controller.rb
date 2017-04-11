class UsersController < ApplicationController

  def index
    # users_tableから曖昧検索をして変数usersに入れる やり方は、where("カラム名 like '%検索テキスト%'")
    @users = User.where("user_name like '%#{params[:user_name]}%'")
    # debugger
    # json形式で値を返す
    render json: @users
  end

  def new
    # userインスタンスを作成
    @user = User.new
  end

  def create
    # userインスタンスに入力された値を代入
    @user = User.new(user_params)
    if @user.save
      redirect_to team_path(@user.team_id)
    else
      flash.now[:alert] = "すべての項目を入力してください"
      render :new
    end
  end

  private
  def user_params
  # 入力された値のうち、指定したカラムに入る値のみ保存する処理。加えて、user作成時にmaster_idとteam_idを保存する。
    params.require(:user).permit(:first_name, :last_name, :user_name).merge(master_id: current_master.id, team_id: params[:team_id])
  end


end
