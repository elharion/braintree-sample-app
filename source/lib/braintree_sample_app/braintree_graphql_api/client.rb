require 'json'

# BraintreeSampleApp::BraintreeGraphqlApi::Client
module BraintreeSampleApp
  module BraintreeGraphqlApi
    class Client

      def initialize(connection = nil)
        @connection = connection || Connection.build
      end

      def tokenize_credit_card(pan:, cvv:, expiration_year:, expiration_month:)
        query = <<-GRAPHQL
          mutation TokenizeCreditCard($input: TokenizeCreditCardInput!) {
            tokenizeCreditCard(input: $input) {
              clientMutationId,
              paymentMethod {
                id
              }
            }
          }
        GRAPHQL
        variables = {
          input: { 
            creditCard: {
              number: pan,
              cvv: cvv,
              expirationYear: expiration_year,
              expirationMonth: expiration_month 
            }
          }
        }

        connection.post do |req|
          req.body = {
            query: query,
            variables: variables
          }.to_json
        end
      end

      private

      attr_reader :connection
    end
  end
end