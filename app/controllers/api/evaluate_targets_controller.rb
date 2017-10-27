class Api::EvaluateTargetsController < ApiController
  
  before_action :authenticate_user!
  
  def create
    # TODO: create some awesome things here!
    render json: {message: "Created"}, status: 200
  end
  
  private
  
    def evaluate_target_params
      params.require(:evaluate_target)
            .permit(:country_code, :target_group_id, locations: [])
    end
    
end
