module BraintreeSampleApp
  module BraintreeGraphqlApi
    class Requests


      def initialize(connection = nil)
        @connection = connection || Connection.build
      end

      def tokenize_card(pan:, cvv:, expiration_year:, expiration_month:)
        
      end

      private


    end
  end
end