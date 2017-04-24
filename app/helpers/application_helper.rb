module ApplicationHelper
  # direct_messageのリンク名を作成する。
  def direct_links
    conbined_users = ""
    @directs.each do |direct|
      direct.users.each do |user|
        conbined_users += user.user_name + ","
      end
    end
    return conbined_users
  end
end
