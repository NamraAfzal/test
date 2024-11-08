require 'rails_helper'

RSpec.describe "posts/index", type: :view do
  current_user = User.first_or_create!(email: 'jake@ymail.com', password: '123456', password_confirmation: '123456')
  before(:each) do
    assign(:posts, [
      Post.create!(
        title: "Title",
        body: "MyText",
        user: current_user,
        views: 14
      ),
      Post.create!(
        title: "Title",
        body: "MyText",
        user: current_user,
        views: 12
      )
    ])
  end

  it "renders a list of posts" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Title".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(current_user.id.to_s), count: 4
    assert_select cell_selector, text: Regexp.new(14.to_s), count: 1
    assert_select cell_selector, text: Regexp.new(12.to_s), count: 1

  end
end
