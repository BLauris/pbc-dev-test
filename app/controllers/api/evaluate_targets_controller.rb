class Api::EvaluateTargetsController < ApiController
  
  before_action :authenticate_user!
  
  def create
    # TODO: create some awesome things here!
    render json: {message: "Created"}, status: 200
  end
    
end
