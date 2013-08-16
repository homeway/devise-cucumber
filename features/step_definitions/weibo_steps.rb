#encoding: utf-8

假如(/^已经有一个用户A已经登录$/) do
  create_a_registed_user
  sign_in(@user.email, @user.password)
  page.should have_content('登录成功！')
end

#这到底是假如？还是而且？Cucumber只能检测到假如这个步骤哦
假如(/^用户A发了一条信息“([^“]*)”$/) do |message_text|
  @message_text = message_text
  page.should have_field('message_content')
  fill_in 'message_content', :with => @message_text
  click_button '发布'
end

假如(/^用户A访问自己微博主页$/) do
  visit user_path(@user)
end

那么(/^用户A应该能看到这条微博的删除链接$/) do
  pending # express the regexp above with the code you wish you had
end

假如(/^此时删除微博$/) do
  pending # express the regexp above with the code you wish you had
end

那么(/^应该收到一个删除确认的警告（以防止误删）$/) do
  pending # express the regexp above with the code you wish you had
end

假如(/^确认删除$/) do
  pending # express the regexp above with the code you wish you had
end

那么(/^应该收到该微博被删除的提示$/) do
  pending # express the regexp above with the code you wish you had
end

那么(/^这条微博应该立即从微博主页上消失$/) do
  pending # express the regexp above with the code you wish you had
end

那么(/^用户A应该收到“成功发送”的提示$/) do
  page.should have_content '成功发布一条微博！'
end

假如(/^有一个用户B未登录，而此时用户A已经退出$/) do
  click_link '注销'
  page.should have_content '注销成功'
end

假如(/^用户B访问网站主页面时$/) do
  visit root_path
end

那么(/^用户B应该能在所有用户的微博列表中找到这条信息$/) do
  page.should have_content @message_text
end

假如(/^用户B访问用户A的主页面时$/) do
  pending # express the regexp above with the code you wish you had
end

那么(/^用户B应该能在用户A的微博列表中找到这条信息$/) do
  pending # express the regexp above with the code you wish you had
end

假如(/^用户A单独打开这条微博信息$/) do
  pending # express the regexp above with the code you wish you had
end

那么(/^用户A应该能看到“这是我的第一条微博”这条信息的单独界面$/) do
  pending # express the regexp above with the code you wish you had
end
