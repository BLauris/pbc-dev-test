class HtmlNodesToCents < Base::ToCents
  
  include Virtus.model(strict: true)
  attribute :url, String, default: "http://time.com/"
  
  def count!
    begin
      count = total_count
    rescue => error
      add_error(error)
    end
  end
  
  private
  
    def html
      @html ||= Nokogiri::HTML(open(url).read)
    end
  
    def tags_with_counts
      @tags_with_count ||= html.xpath("//*").map(&:name).each_with_object({}) {
        |n, r| r[n] = (r[n] || 0) + 1 
      }
    end
    
    def total_count
      @total_count ||= tags_with_counts.values.sum
    end
    
end