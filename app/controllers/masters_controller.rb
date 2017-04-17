class MastersController < ApplicationController
# 常にmasterのログインを要求する
before_action :authenticate_master!
# masterメニュー画面
  def show
    # すべてのteamから現在所属しているteamを引く。
    @teams = Team.all - current_master.teams
  end

end
