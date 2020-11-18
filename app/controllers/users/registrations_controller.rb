class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  def create
    super do |resource|
      if resource.valid?
        return render json: {
        status: {code: 200, message: 'Account created successfully.'},
        data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
        }
      else
        return render json: {status: {code: 401, message: resource.errors.map{ |a,b| "#{a} #{b}" }}}
      end
    end
  end

  private

  def respond_to_on_destroy
    head :ok
  end

end
