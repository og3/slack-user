class UsersController < ApplicationController

  def new
    # userインスタンスを作成
    @user = User.new
  end

  def create
    # userインスタンスに入力された値を代入
    @user = User.new(user_params)
    if @user.save
      # message機能追加後にリダイレクト先を変更する
      redirect_to root_path
    else
      flash.now[:alert] = "すべての項目を入力してください"
      render :new
    end
  end

  private
  def user_params
  # 入力された値のうち、指定したカラムに入る値のみ保存する処理。加えて、user作成時にmaster_idとteam_idを保存する。
    params.require(:user).permit(:first_name, :last_name, :user_name{ master_ids:[], team_ids:[] })
  end

end
