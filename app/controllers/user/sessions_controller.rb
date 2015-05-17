class User::SessionsController < Devise::SessionsController
before_filter :configure_sign_in_params, only: [:create]

  def new
    super
  end

  def create
    @user = User.find_by_username(params[:session][:username])
    if @user && @user.valid_password?(params[:session][:password])
      sign_in @user
      flash[:notice] = "You have been logged in successfully!"
      redirect_to root_path
    else
      flash[:alert] = "Invalid username/password combination!"
      render 'new'
    end
    ## remember me?
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  # protected

  # You can put the params you want to permit in the empty array.
  def configure_sign_in_params
    devise_parameter_sanitizer.for(:sign_in) << :username
  end
end
