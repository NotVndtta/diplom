require 'rails_helper'

RSpec.describe "experiences/index", type: :view do
  before(:each) do
    assign(:experiences, [
      Experience.create!(
        description: "MyText",
        company: "Company",
        user_id: ""
      ),
      Experience.create!(
        description: "MyText",
        company: "Company",
        user_id: ""
      )
    ])
  end

  it "renders a list of experiences" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Company".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("".to_s), count: 2
  end
end
