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

        send_request(query, variables)
      end

      def charge_payment_method(payment_method_id, amount)
        query = <<-GRAPHQL
          mutation ChargePaymentMethod($input: ChargePaymentMethodInput!) {
            chargePaymentMethod(input: $input) {
              transaction {
                id
                status
              }
            }
          }
        GRAPHQL

        variables = {
          input: {
            paymentMethodId: payment_method_id,
            transaction: {
              amount: amount
            }
          }
        }

        send_request(query, variables)
      end

      def charge_paypal_account(paypal_account_id: "fake-paypal-one-time-nonce", amount:)
        query = <<-GRAPHQL
          mutation ChargePayPalAccount($input: ChargePayPalAccountInput!) {
            chargePayPalAccount(input: $input) {
              transaction {
                id
                status
              }
            }
          }
        GRAPHQL

        variables = {
          input: {
            paymentMethodId: paypal_account_id,
            transaction: {
              amount: amount
            }
          }
        }

        send_request(query, variables)
      end

      def charge_venmo_account(venmo_account_id: "fake-venmo-account-nonce", amount:)
        query = <<-GRAPHQL
          mutation ChargeVenmoAccount($input: ChargeVenmoAccountInput!) {
            chargeVenmoAccount(input: $input) {
              transaction {
                id
                status
              }
            }
          }
        GRAPHQL

        variables = {
          input: {
            paymentMethodId: venmo_account_id,
            transaction: {
              amount: amount
            }
          }
        }

        send_request(query, variables)

      end

      private

      attr_reader :connection

      def send_request(query, variables)
        connection.post do |req|
          req.body = {
            query: query,
            variables: variables
          }.to_json
        end
      end
    end
  end
end