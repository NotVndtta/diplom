require 'rails_helper'

RSpec.describe "job_cards/show", type: :view do
  before(:each) do
    assign(:job_card, JobCard.create!(
      farm_name: "Farm Name",
      remuneration: 2,
      work_amount: 3,
      description: "MyText",
      location: "Location",
      status: "Status",
      count_users: 4,
      user_id: ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Farm Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Location/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(//)
  end
end
