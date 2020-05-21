require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "Category should bbe valid" do
    @category = Category.new(name: "Sports")
    asserts @category.valid?
  end
end