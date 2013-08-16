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