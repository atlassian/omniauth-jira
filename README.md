omniauth-jira
=============

A simple [OmniAuth](https://github.com/intridea/omniauth) strategy for Atlassian JIRA.

Install
-------

    gem 'omniauth-jira'

Usage
-----

    use OmniAuth::Builder do
      provider :JIRA, 
        "<consumer_key>", 
        OpenSSL::PKey::RSA.new(IO.read(File.dirname(__FILE__) + "<PRIVATE_KEY_FILE>")),
        :client_options => { :site => "<http://jira.url>" }
    end

Contributing
------------

Do it.