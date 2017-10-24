class Country < ActiveRecord::Base
  
  validates :country_code, :panel_provider_id, presence: true
  validates :country_code, length: { minimum: 2, maximum: 2 }
  
  before_save :uppercase_country_code, if: Proc.new { |c| c.country_code_changed? && c.country_code.present? }
  
  private
  
    def uppercase_country_code
      self.country_code = self.country_code.upcase
    end
end
