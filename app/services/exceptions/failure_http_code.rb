module Exceptions
  class FailureHttpCode < StandardError
    attr_accessor :status_code, :message

    def initialize(status_code, message)
      @status_code = status_code
      @message = message
    end

    def to_s
      "Bittrex returned failure http code (#{status_code}) with message #{message}"
    end
  end
end
