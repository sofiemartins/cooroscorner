class User::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]

  def new
    super
  end

  def create
    @user = User.find_by(username: params[:sessions][:username].downcase)
    log_in @user
    ## remember me?
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
