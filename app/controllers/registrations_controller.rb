class RegistrationsController < Devise::RegistrationsController
  clear_respond_to
  respond_to :json

  def create
    @user = User.new(user_params)
    if user.save
      log_in @user
      flash[:success] = "Your account has been created successfully!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private 
  
    def user_params
      params.require(:user).permit(:name, :email, 
		:password, :password_confirmation)
    end
end
