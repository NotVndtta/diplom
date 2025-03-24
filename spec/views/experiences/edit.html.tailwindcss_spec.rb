require 'rails_helper'

RSpec.describe "experiences/edit", type: :view do
  let(:experience) {
    Experience.create!(
      description: "MyText",
      company: "MyString",
      user_id: ""
    )
  }

  before(:each) do
    assign(:experience, experience)
  end

  it "renders the edit experience form" do
    render

    assert_select "form[action=?][method=?]", experience_path(experience), "post" do

      assert_select "textarea[name=?]", "experience[description]"

      assert_select "input[name=?]", "experience[company]"

      assert_select "input[name=?]", "experience[user_id]"
    end
  end
end
