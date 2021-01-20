require 'faraday'
require 'base64'

module BraintreeSampleApp
  module BraintreeGraphqlApi
    class Connection
      def self.build
        Faraday.new(
          url: 'https://payments.sandbox.braintree-api.com/graphql',
          headers: {
            'Content-Type' => 'application/json',
            'Braintree-Version' => '2019-01-01',
            'Authorization' => Base64.encode64("#{ENV["BRAINTREE_PUBLIC_KEY"]}:#{ENV["BRAINTREE_PRIVATE_KEY"]}").gsub("\n", "")
          }
        )
      end
    end
  end
end