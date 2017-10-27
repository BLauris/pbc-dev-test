class Api::TokensController < ApiController
  
  before_action :token
  
  def generate
    if token.present?
      render json: { token: token }, status: 200
    else
      render json: { message: "User not found" }, status: 404
    end
  end
  
  private
  
    def user_params
      params.require(:user).permit(:email)
    end
  
    def token
      @token ||= TokenService.generate_token!(user_params[:email])
    end
end
