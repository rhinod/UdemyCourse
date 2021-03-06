require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create(name: "Sports")
    @user = User.create(username: "Joe", email: "Joe@mail.com", password: "password", admin: true)
  end

  test "should get index" do
    get categories_url
    assert_response :success
  end

  test "should get new" do
    session[:user_id] = @user.id
    get new_category_url
    assert_response :success
  end

  test "should create category" do
    assert_difference('Category.count', 1) do
      post categories_url, params: { category: { name: "Travel" } }
    end
  
    assert_redirected_to category_url(Category.last)
  end

  test "should show category" do
    get category_url(@category)
    assert_response :success
  end
  

  test "Redirect when admin not logged" do
    assert_no_diference 'Category.count' do
      post :create, category: { name: "Sports" }

    end
    assert_redirected_to categories_path
  end
end
