#encoding: utf-8
module MessagesHelper
  def get_username(message)
    @user = message.user
    if(@user)
      @user.name
    else
      '未知用户'
    end
  end

  def time_ago_message(ago_time)
    sec = (Time.now - ago_time).to_i
    msg = "#{sec}秒前"
    if    sec > 60*60*24*30*12
      msg = "#{sec/60/24/30/12}月前"
    elsif sec > 60*60*24*30
      msg = "#{sec/60/24/30}月前"
    elsif sec > 60*60*24
      msg = "#{sec/60/60/24}天前"
    elsif sec > 60*60
      msg = "#{sec/60/60}小时前"
    elsif sec > 60
      msg = "#{sec/60}分钟前"
    end
    msg
  end
end
