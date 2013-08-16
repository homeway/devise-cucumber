#encoding: utf-8

def create_visitor
  @visitor ||= { :name => "一凡", :email => "even@example.com",
    :password => "12345678", :password_confirmation => "12345678" }
end

def create_not_registed_user
  @visitor ||= { :email => "adi@example.com", :password => "12345566"}
  delete_user
end

def create_a_registed_user
  create_visitor
  delete_user
  @user = FactoryGirl.create(:user, @visitor)
end

def delete_user
  @user ||= User.where(:email => @visitor[:email]).first
  @user.destroy unless @user.nil?
end

def find_user
  @user ||= User.where(:email => @visitor[:email]).first
end

def sign_up
  delete_user
  visit '/users/sign_up'
  fill_in "user_name", :with => @visitor[:name]
  fill_in "user_email", :with => @visitor[:email]
  fill_in "user_password", :with => @visitor[:password]
  fill_in "user_password_confirmation", :with => @visitor[:password_confirmation]
  click_button "注册"
  find_user
end

def sign_in(email, password)
  visit '/users/sign_in'
  fill_in 'user_email', :with => email
  fill_in 'user_password', :with => password
  click_button "登录"
end

假如(/^我已经登录到系统中$/) do
  create_a_registed_user
  sign_in(@user.email, @user.password)
  page.should have_content('登录成功！')
end

当(/^我编辑我自己的帐户资料并保存$/) do
  visit '/users/edit'
  fill_in 'user_name', :with => '我的新名字'
  fill_in 'user_current_password', :with => @user.password
  click_button "保存"
end

那么(/^我应当看到帐户资料已经被成功修改了$/) do
  page.should have_content('您的帐户信息已修改成功！')
end

假如(/^我现在没有登录$/) do
  visit '/'
end

假如(/^我使用合法数据注册$/) do
  create_visitor
  sign_up
end

那么(/^我应当收到“注册成功”的信息提示$/) do
  page.should have_content('欢迎您！您已注册成功！')
  page.should_not have_link('登录')
  page.should have_link('注销')
end

假如(/^我使用非法的邮箱名称注册$/) do
  create_visitor
  @visitor[:email] = 'abcde.f'
  sign_up
end

那么(/^我应当收到一个“邮箱名称非法”的提示信息$/) do
  page.should have_content('Email 是无效的')
end

假如(/^我没有输入密码$/) do
  create_visitor
  @visitor[:password] = ''
  @visitor[:password_confirmation] = ''
  sign_up
end

那么(/^我应当收到一个“密码不能为空”的提示信息$/) do
  page.should have_content('Password 不能为空字符')
end

假如(/^我没有输入确认密码$/) do
  create_visitor
  @visitor[:password_confirmation] = ''
  sign_up
end

那么(/^我应当收到一个“确认密码不能为空”的提示信息$/) do
  page.should have_content('Password 与确认值不匹配')
end

那么(/^我应当收到一个“两次密码输入不一致”的提示信息$/) do
  create_visitor
  @visitor[:password] = '12345678'
  @visitor[:password_confirmation] = '12345677'
  sign_up
end

当(/^我注销$/) do
  click_link '注销'
end

那么(/^我应当看到一个注销的提示$/) do
  page.should have_content('注销成功')
end

那么(/^我应当返回主页$/) do
  current_path.should == root_path 
end

那么(/^我现在应该是注销的状态$/) do
  page.should have_link('登录')
end

假如(/^我是一个已经注册的系统用户$/) do
  create_a_registed_user
end

当(/^我访问用户列表的页面$/) do
  visit '/users/list'
end

那么(/^我应当能看到我自己的名字$/) do
  page.should have_content(@user.name)
end

假如(/^我还不是系统用户$/) do
  create_not_registed_user
end

当(/^我使用一个预想的邮件地址作为帐户登录时$/) do
  sign_in(@visitor[:email], @visitor[:password])
end

那么(/^我应当收到登录失败的提示$/) do
  page.should have_content('邮箱或密码错误')
end

假如(/^我还没登录$/) do
  visit '/'
  page.should have_link('登录')
end

当(/^我用自己帐户登录时$/) do
  sign_in(@user.email, @user.password)
end

那么(/^我应该看到一条登录成功的提示$/) do
  page.should have_content('登录成功')
end

当(/^我返回网站主页$/) do
  visit '/'
end

那么(/^我就成功登录到系统中$/) do
  page.should_not have_link('登录')
  page.should have_link('注销')
end

当(/^我使用一个错误的邮件地址作为帐户登录时$/) do
  sign_in("#{@user.email}aaa", @user.password)
end

当(/^我使用一个错误的密码作为帐户登录时$/) do
  sign_in(@user.email, "#{@user.password}ppp")
end