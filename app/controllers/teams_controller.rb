class TeamsController < ApplicationController
  before_action :authenticate_master!

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    # @teamにmasterインスタンスをもたせて、そこにログイン中のユーザー情報をいれる
    @team.masters << current_master
    if @team.save
      redirect_to new_team_user_path(@team.id)
    else
      flash.now[:alert] = "必要項目を入力してください"
      render :new
    end
  end

  # def join
  #   # ログイン中のユーザーのinvited_by_idを取得する
  #   # @join = current_user.invited_by_id
  #   # invited_by_idに対応するユーザーを探してくる
  #   @invite_user = User.find(current_user.invited_by_id)
  #   current_user.team_id = @invite_user.team_id
  #   @current_user_team_id = current_user.team_id
  #   if @current_user_team_id.save
  #     redirect_to root_path
  #   else
  #     render :join
  #   end
  # end

  private
  def team_params
    params.require(:team).permit(:name, :purpose, :memo)
  end
end
