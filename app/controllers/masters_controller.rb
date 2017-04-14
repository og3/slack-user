class MastersController < ApplicationController
# 常にmasterのログインを要求する
before_action :authenticate_master!
# masterメニュー画面
  def show
  end

end
