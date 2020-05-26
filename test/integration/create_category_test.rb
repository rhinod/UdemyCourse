require 'test_helper'

def setup 
  @user = User.create(username: "Joe", email: "Joe@mail.com", password: "password", admin: true)
end



class CreateCategoryTest < ActionDispatch::IntegrationTest
  test "Get category form and create category" do
    sign_in_as(@user, "password")
    get "/categories/new"
    assert_response :success
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: {name: "Sports"} }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Sports", response.body
  end

  test "Get category form and reject invalid category submission" do
    sign_in_as(@user, "password")
    get "/categories/new"
    assert_response :success
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: {name: " "} }
    end
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'

    assert_match "errores", response.body
  end


end
