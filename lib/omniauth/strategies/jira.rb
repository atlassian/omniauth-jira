require 'omniauth-oauth'
require 'multi_json'
require 'net/http'

module OmniAuth
  module Strategies
    class JIRA < OmniAuth::Strategies::OAuth

      option :name, 'jira'
      option :client_options, {
        :signature_method => 'RSA-SHA1',
        :request_token_path => '/plugins/servlet/oauth/request-token', 
        :authorize_path => "/plugins/servlet/oauth/authorize",
        :access_token_path => '/plugins/servlet/oauth/access-token',
        :site => nil
      }

      uid{ raw_info['name'] }

      info do
        {
          :name => raw_info['name'],
          :self => raw_info['self']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= MultiJson.decode(access_token.get('/rest/auth/1/session').body)
      rescue ::Errno::ETIMEDOUT
        raise ::Timeout::Error
      end
    end
  end
end

OmniAuth.config.add_camelization 'jira', 'JIRA'
