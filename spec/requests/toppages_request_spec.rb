require 'rails_helper'

RSpec.describe "Toppages", type: :request do
  it "200レスポンスを返すこと" do
    get root_url
    expect(response).to have_http_status(200)
  end
end
