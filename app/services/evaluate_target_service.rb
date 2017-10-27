class EvaluateTargetService < Validators::TargetEvaluation
  
  include Virtus.model(strict: true)
  attribute :country_code, String
  attribute :target_group_id, String
  attribute :locations, Array
  attribute :errors, Hash, default: :validate!

  def evaluate
    {message: "Great Success"}
  end
  
  private
  
    def validate!
      errors = {}
      errors[:country_code] = validate_country
      errors[:target_group_id] = validate_target_group
      errors[:locations] = validate_locations
      errors.select { |_, value| !value.nil? }.present? ? errors : {}
    end
end