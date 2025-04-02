require 'rails_helper'

RSpec.describe "experiences/new", type: :view do
  before(:each) do
    assign(:experience, Experience.new(
      description: "MyText",
      company: "MyString",
      user_id: ""
    ))
  end

  it "renders new experience form" do
    render

    assert_select "form[action=?][method=?]", profile_experience_path, "post" do

      assert_select "textarea[name=?]", "experience[description]"

      assert_select "input[name=?]", "experience[company]"

      assert_select "input[name=?]", "experience[user_id]"
    end
  end
end
