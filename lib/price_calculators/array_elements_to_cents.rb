class ArrayElementsToCents < Base::ToCents
  
  ARRAY_MIN_SIZE = 10
  
  include Virtus.model(strict: true)
  attribute :url, String, default: "http://openlibrary.org/search.json?q=the+lord+of+the+rings"
  
  def count!
    begin
      response_json.each { |data| deep_array_count(data) }
      count
    rescue => error
      add_error(error)
    end
  end
  
  private 
  
    def deep_array_count(object)
      if array_or_hash?(object)
        self.count += 1 if valid_array_to_count?(object)
        object.each{ |element| deep_array_count(element) } 
      end
    end
    
    def response
      @response ||= Net::HTTP.get_response(URI.parse(url))
    end
    
    def response_body
      @response_body ||= response.body
    end
    
    def response_json
      @response_json ||= JSON.parse(response_body)
    end
  
    def array_or_hash?(object)
      object.is_a?(Array) || object.is_a?(Hash)
    end
    
    def valid_array_to_count?(object)
      object.size >= ARRAY_MIN_SIZE && !object.is_a?(Hash)
    end
    
end