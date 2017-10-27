class Api::EvaluateTargetsController < ApiController
  
  before_action :authenticate_user!
  before_action :target_service
  
  def create
    if target_service.errors.blank?
      render json: target_service.evaluate, status: 200
    else
      render json: { errors: target_service.errors }, status: 406
    end
  end
  
  private
  
    def evaluate_target_params
      params.require(:evaluate_target).permit(:country_code, :target_group_id, locations: [:id, :panel_size])
    end
    
    def target_service
      @target_service ||= EvaluateTargetService.new(
        country_code: evaluate_target_params[:country_code], 
        target_group_id: evaluate_target_params[:target_group_id],
        locations: evaluate_target_params[:locations]
      )
    end
    
end
