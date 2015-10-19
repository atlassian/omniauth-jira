omniauth-jira
=============

A simple [OmniAuth](https://github.com/intridea/omniauth) strategy for Atlassian JIRA.

Install
-------

    gem 'omniauth-jira'

Usage
-----

Create a private key and certificate for use with your JIRA instance:

    openssl req -x509 -nodes -days 365 -newkey rsa:1024 -sha1 -keyout jira_private_key.pem -out jira_x509_certificate.pem

Extract the public key:

    openssl x509 -pubkey -noout -in jira_x509_certificate.pem > jira_public_key.key

Configure OAuth on your JIRA instance. You'll need to specify a consumer key and the public key (above). More instructions here: https://developer.atlassian.com/jiradev/jira-apis/jira-rest-apis/jira-rest-api-tutorials/jira-rest-api-example-oauth-authentication

Then setup the OmniAuth provider in your code:

    use OmniAuth::Builder do
      provider :JIRA, 
        "<consumer_key>", 
        OpenSSL::PKey::RSA.new(IO.read(File.dirname(__FILE__) + "<PRIVATE_KEY_FILE>")),
        :client_options => { :site => "<http://jira.url>" }
    end

Contributing
------------

Do it.