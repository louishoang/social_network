require 'rails_helper'

feature "User authentication" do

  scenario "authenticated user can login" do

    user = FactoryGirl.create(:user)
    visit root_path

    find("#login_email").set user.email
    find("#login_password").set "password"
    click_on "Login"

    expect(page).to have_selector("#posts-collection")
  end

  scenario "unauthenticated user can't login" do

    user = FactoryGirl.create(:user)
    visit root_path

    find("#login_email").set user.email
    find("#login_password").set "password123"
    click_on "Login"

    expect(page).to have_content("Invalid email or password.")
  end

  scenario "User can create account" do

    user = FactoryGirl.build(:user)
    visit root_path

    find("#registration_email").set user.email
    find("#registration_password").set "password"
    find("#registration_password_confirmation").set "password"
    click_on "Sign Up"

    new_user = User.last
    expect(new_user.email).to eq(user.email)
  end  
end