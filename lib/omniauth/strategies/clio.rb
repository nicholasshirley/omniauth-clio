require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Clio < OmniAuth::Strategies::OAuth2
      option :name, "clio"

      option :client_options, {
        :site => 'https://app.clio.com',
        :authorize_url => '/oauth/authorize',
        :token_url => '/oauth/token',
        :redirect_uri => 'http://localhost:3000'
      }

      uid { raw_info['user']['id']}

      info do
        {
          :last_name => raw_info['user']['last_name'],
          :first_name => raw_info['user']['first_name'],
          :email => raw_info['user']['email'],
          :firm => raw_info['account']['name'],
        }
      end

      extra do
        {:raw_info => raw_info}
      end

      def raw_info
        @raw_info ||= access_token.get('/api/v4/users/who_am_i').parsed
      end
    end
  end
end

