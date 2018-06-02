require 'httparty'

class Request
  include HTTParty
  include Helper
  attr_accessor :url, :response_code

  def initialize(url, url_args)
    @url = bittrex_url(url, url_args)
  end


  def get!
    response = self.class.get(url)
    response_code = response.code
    response_hash = response.parsed_response
    if response_code != 200
      message = response_hash.is_a?(Hash) ? response_hash[:message] : response_hash
      raise Exceptions::FailureHttpCode.new(response_code, message)
    end
    response_hash
  end
end
