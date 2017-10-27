class EvaluateTargetService < Validators::TargetEvaluation
  
  CALCULATORS = ["ArrayElementsToCents", "HtmlNodesToCents", "LettersToCents"]
  
  include Virtus.model(strict: true)
  attribute :country_code, String
  attribute :target_group_id, String
  attribute :locations, Array
  attribute :errors, Array, default: :validate!

  def evaluate
    CALCULATORS.each_with_object([]) do |calculator, providers|
      ActiveRecord::Base.transaction do
        panel_provider = panel_provider(calculator)
        country = add_country!(panel_provider.id)
        target_group = add_target_group!(panel_provider.id)
        add_locations!(country.id)
        providers << panel_provider
      end
    end
  end
  
  private
  
    def validate!
      errors = []
      errors << validate_country!
      errors << validate_target_group!
      errors << validate_locations!
      errors << already_belongs_to_country?
      errors.compact.flatten
    end
    
    def panel_provider(calculator_name)
      calculator = calculator_name.constantize.new
      
      PanelProvider.create(
        price_in_cents: calculator.count!,
        code: Faker::Code.ean
      )
    end
    
    def add_country!(panel_provider_id)
      Country.create(country_code: country_code, panel_provider_id: panel_provider_id)
    end
    
    def add_target_group!(panel_provider_id)
      target_group = TargetGroup.find(target_group_id).dup
      target_group.panel_provider_id = panel_provider_id
      target_group.save
    end
    
    def add_locations!(country_id)
      locations.each{ |location| Location.find(location[:id]).update(country_id: country_id) }
    end
    
end