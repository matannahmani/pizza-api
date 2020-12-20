class Users::SessionsController < Devise::SessionsController
  respond_to :json

  # def create
  #   params[:user].merge!(remember_me: 2.days)
  #   super
  # end

  private

  def respond_with(resource, _opts = {})
    if !current_user.nil?
      render json: {
      status: {code: 200, message: 'Logged in successfully.'},
      data: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
      }
    else
      render json: { status: {code: 401, message: 'Email or password is invaild'} }
    end
  end

  def respond_to_on_destroy
    head :ok
  end
end
