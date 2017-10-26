class LettersToCents < Base::ToCents
  
  include Virtus.model(strict: true)
  attribute :url, String, default: "http://time.com/"
  attribute :letters, String, default: "a"
  
  def count!
    begin
      count = letter_count
    rescue => error
      add_error(error)
    end
  end
  
  private
    
    def letter_count
      visible_text.scan(letters).count
    end
    
    def html
      @html ||= Nokogiri::HTML(open url)
    end
    
    def visible_text
      @visible_text ||= html.at('body').inner_text
    end
  
end