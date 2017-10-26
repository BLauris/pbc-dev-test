require 'net/http'
require 'open-uri'

class Base::ToCents
  
  include Virtus.model(strict: true)
  attribute :error, Hash, default: {}
  attribute :count, Integer, default: 0
  
  private
  
    def add_error(e)
      error[:error_class] = e.class.name 
      error[:message] = e.message
    end
    
end