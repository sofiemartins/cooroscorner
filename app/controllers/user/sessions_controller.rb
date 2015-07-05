class User::SessionsController < Devise::SessionsController
before_filter :configure_sign_in_params, only: [:create]

  def new
    super
  end

  def create
    @user = User.find_by_username(params[:session][:username])
    if @user && @user.valid_password?(params[:session][:password])
      sign_in @user
      if !!params[:session][:remember_me]
        @user.remember_me!
      end
      flash.keep[:notice] = "You have been logged in successfully!"
      redirect_to root_path
    else
      flash.now[:alert] = "Invalid username/password combination!"
      render 'new'
    end
  end

  # DELETE /resource/sign_out
  def destroy
    if user_signed_in?
      sign_out current_user
      flash.keep[:notice] = "Signed out successfully."
    else 
      flash.now[:alert] = "You have to log in before logging out!"
    end
    redirect_to root_path
  end

  # protected

  # You can put the params you want to permit in the empty array.
  def configure_sign_in_params
    devise_parameter_sanitizer.for(:sign_in) << :username
  end
end
