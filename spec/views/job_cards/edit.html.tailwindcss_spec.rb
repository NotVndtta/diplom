require 'rails_helper'

RSpec.describe "job_cards/edit", type: :view do
  let(:job_card) {
    JobCard.create!(
      farm_name: "MyString",
      remuneration: 1,
      work_amount: 1,
      description: "MyText",
      location: "MyString",
      status: "MyString",
      count_users: 1,
      user_id: ""
    )
  }

  before(:each) do
    assign(:job_card, job_card)
  end

  it "renders the edit job_card form" do
    render

    assert_select "form[action=?][method=?]", job_card_path(job_card), "post" do

      assert_select "input[name=?]", "job_card[farm_name]"

      assert_select "input[name=?]", "job_card[remuneration]"

      assert_select "input[name=?]", "job_card[work_amount]"

      assert_select "textarea[name=?]", "job_card[description]"

      assert_select "input[name=?]", "job_card[location]"

      assert_select "input[name=?]", "job_card[status]"

      assert_select "input[name=?]", "job_card[count_users]"

      assert_select "input[name=?]", "job_card[user_id]"
    end
  end
end
