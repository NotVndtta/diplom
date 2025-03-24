require 'rails_helper'

RSpec.describe "experiences/show", type: :view do
  before(:each) do
    assign(:experience, Experience.create!(
      description: "MyText",
      company: "Company",
      user_id: ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Company/)
    expect(rendered).to match(//)
  end
end
