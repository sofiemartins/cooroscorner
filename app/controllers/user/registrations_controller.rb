class User::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    super 
  end

  def list
    if !current_user || !current_user.admin
      raise ActionController::RoutingError.new('Not Found')
    else
    end
  end
 
  # DELETE /resource
  def destroy
    if !change_priviledges?
      raise ActionController::RoutingError.new('Not Found')
    else
      user = User.find_by_username(params[:username])
      user.delete
      if current_user.admin
        redirect_to '/list/users'
      else
        redirect_to root_path
      end
    end
  end  

  # GET /resource/edit
  def edit
    if !change_priviledges?
      raise ActionController::RoutingError.new('Not Found')
    else
    end
  end

  def submit_edit
    if !change_priviledges?
      raise ActionController::RoutingError.new('Not Found')
    else
      user = User.find_by_username(params[:username])
      evaluate_username_field(user)
      evaluate_email_field(user)
      evaluate_password_fields(user,
			params[:edit][:new_password],
			params[:edit][:new_password_confirmation])
      user.save
      redirect_to root_path
    end
  end
 
  private 
    def evaluate_password_fields(user, password, password_confirmation)
      if authenticate_password_input(user)
        user.update_attributes(:password => password,
				:password_confirmation => password_confirmation)
        user.save
      end
    end

  private
    def evaluate_email_field(user)
      email = params[:edit][:email]
      if email_given_and_unique(email)
        user.email = email
      else
        if !!email
          flash.now[:alert] = "This email-address is already in use. Please pick another"
        end
      end
    end

  private
    def evaluate_username_field(user)
      username = params[:edit][:username]
      if username_given_and_unique(username)
        user.username = username
        user.save
      else
        flash.now[:alert] = "This username is already in use. Please pick another."
      end
    end

  private
    def username_given_and_unique(username)
      !!username && !User.find_by_username(username)
    end

  private
    def email_given_and_unique(email)
      !!email && !User.find_by_email(email)
    end

  private
    def user_params
      params.require(:user).permit(:email, :username,
			:password, :password_confirmation)
    end

  private
    def change_priviledges?
      user_logged_in? && ( right_user? || admin_priviledges? ) 
    end

  private 
    def user_logged_in?
      !!current_user
    end

  private
    def right_user?
      current_user.username == params[:username] 
    end

  private
    def admin_priviledges?
      current_user.admin
    end
 
  private
    def authenticate_password_input(user)
       password_fields_are_all_filled &&
       user.valid_password?(params[:edit][:old_password]) &&
       (params[:edit][:new_password] == params[:edit][:new_password_confirmation])
    end
 
  private
    def password_fields_are_all_filled
      !!params[:edit][:old_password] &&
      !!params[:edit][:new_password] &&
      !!params[:edit][:new_password_confirmation]
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
