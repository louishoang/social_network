module AuthenticationHelper
  def sign_in_as(user)
    visit root_path
    find("#login_email").set user.email
    find("#login_password").set user.password
    click_on "Login"
  end
end