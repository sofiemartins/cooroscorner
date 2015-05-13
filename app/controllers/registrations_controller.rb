class RegistrationsController < Devise::RegistrationsController
  clear_respond_to
  respond_to :json

  def new
  end

  def create
    @user = User.new(user_params)
    if user.save
      log_in @user
      flash[:success] = "Your account has been created successfully!"
      redirect_to root 
    else
      render 'new'
    end
  end

  private 
  
    def user_params
      params.require(:user).permit(:email, :username 
		:password, :password_confirmation)
    end
end
