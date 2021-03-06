class User::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    raise ActionController::RoutingError.new('Not Found') 
  end

  # POST /resource
  def create
    raise ActionController::RoutingError.new('Not Found')
  end

  def list
    if !current_user
      raise ActionController::RoutingError.new('Not Found')
    else
    end
  end
 
  # DELETE /resource
  def destroy
    raise ActionController::RoutingError.new('Not Found')
  end  

  # GET /resource/edit
  def edit
    if !current_user
      raise ActionController::RoutingError.new('Not Found')
    else
    end
  end

  def submit_edit
    raise ActionController::RoutingError.new('Not Found')
  end
 
  # PUT /resource
  # def update
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # You can put the params you want to permit in the empty array.
  def configure_sign_up_params
    devise_parameter_sanitizer.for(:account_update) << :username
  end

  # You can put the params you want to permit in the empty array.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
