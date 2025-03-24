require 'rails_helper'

RSpec.describe "job_cards/index", type: :view do
  before(:each) do
    assign(:job_cards, [
      JobCard.create!(
        farm_name: "Farm Name",
        remuneration: 2,
        work_amount: 3,
        description: "MyText",
        location: "Location",
        status: "Status",
        count_users: 4,
        user_id: ""
      ),
      JobCard.create!(
        farm_name: "Farm Name",
        remuneration: 2,
        work_amount: 3,
        description: "MyText",
        location: "Location",
        status: "Status",
        count_users: 4,
        user_id: ""
      )
    ])
  end

  it "renders a list of job_cards" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Farm Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Location".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Status".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(4.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("".to_s), count: 2
  end
end
