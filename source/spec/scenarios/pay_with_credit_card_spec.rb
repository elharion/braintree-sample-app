require 'spec_helper'

RSpec.describe 'Pay with Credit Card' do
	scenario "works like a charm" do

    client = BraintreeSampleApp::BraintreeGraphqlApi::Client.new

    card_data = {
      number: "4111111111111111"
      cvv: "406"
      expiration_year: "2023"
      expiration_month: "12"
    }

    parsed_response = JSON.parse(client.tokenize_credit_card(card_data).body)
    binding.pry

	end
end