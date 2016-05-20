require 'omniauth-oauth'
require 'multi_json'
require 'net/http'

module OmniAuth
  module Strategies
    class JIRA < OmniAuth::Strategies::OAuth

      option :name, 'jira'
      option :client_options, {
        :signature_method   => 'RSA-SHA1',
        :request_token_path => '/plugins/servlet/oauth/request-token',
        :authorize_path     => '/plugins/servlet/oauth/authorize',
        :access_token_path  => '/plugins/servlet/oauth/access-token',
        :site               => nil
      }

      uid{ user_info['key'] }

      info do
        {
          nickname:  user_info['name'],
          email:     user_info['emailAddress'],
          name:      user_info['displayName'],
          time_zone: user_info['timeZone'],
          locale:    user_info['locale'],
          image:     user_info['avatarUrls'] && user_info['avatarUrls']['48x48'],
          urls: {
            self: session_info['self']
          }
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      credentials do
        return nil unless access_token.params.has_key?(:oauth_token)

        oauth_credentials = {
          'token'   => access_token.params[:oauth_token],
          'secret'  => access_token.params[:oauth_token_secret]
        }
        
        if access_token.params.has_key?(:oauth_expires_in)
          oauth_credentials.merge({
            'expires'     => true,
            'expires_at'  => (Time.now + (access_token.params[:oauth_expires_in].to_i / 1000)).to_i
          })
        end
      end

      def raw_info
        @raw_info ||= {session_info: session_info, user_info: user_info}
      end

      def session_info
        @session_info ||= MultiJson.decode(access_token.get('/rest/auth/1/session').body)
      rescue ::Errno::ETIMEDOUT
        raise ::Timeout::Error
      end

      def user_info
        @user_info ||= MultiJson.decode(access_token.get(session_info['self']).body)
      rescue ::Errno::ETIMEDOUT
        raise ::Timeout::Error
      end
    end
  end
end

OmniAuth.config.add_camelization 'jira', 'JIRA'
