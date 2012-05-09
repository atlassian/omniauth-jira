require 'multi_json'
require 'oauth'
require 'omniauth'

module OmniAuth
  module Strategies
    class JIRA < OmniAuth::Strategies::OAuth
      option :name, "jira"

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, {
        :private_key_file => 'rsa.pem',
        :request_token_path => '/plugins/servlet/oauth/request-token', 
        :authorize_path => "/plugins/servlet/oauth/authorize",
        :access_token_path => '/plugins/servlet/oauth/access-token',
        :site => "http://localhost:2990/jira"
      }

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid{ request.params['user_id'] }

      info do
        {
          :name => raw_info['name'],
          :location => raw_info['city']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= MultiJson.decode(access_token.get('/rest/auth/2/session')).body
      end
    end
  end
end

OmniAuth.config.add_camelization 'oauth', 'OAuth'
