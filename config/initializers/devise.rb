Devise.setup do |config|
  config.secret_key = '5112af0d94cf84231d4361638c8bdc302ec446b6f791d92bff57cdfe8bf308762c049482587fb20c5291b1ef3939658e4eeab1ed37996a60216afa8f65ba282e'

  config.mailer_sender = 'matkingusev@hotmail.com'

  # config.mailer = 'Devise::Mailer'

  require 'devise/orm/active_record'

  config.authentication_keys = [ :username ]

  # config.request_keys = []

  config.case_insensitive_keys = [ :email, :username ]

  config.strip_whitespace_keys = [ :email, :username ]

  # config.params_authenticatable = true

  # config.http_authenticatable = false

  # config.http_authenticatable_on_xhr = true

  # config.http_authentication_realm = 'Application'

  # config.paranoid = true

  config.skip_session_storage = [:http_auth]

  # config.clean_up_csrf_token_on_authentication = true

  config.stretches = Rails.env.test? ? 1 : 10

  # config.pepper = '840d7590359525160a9a0ae1c799317fa7e6e76776a28032038032caccdd85c0fa4323cc68a5fd6cfcb2602a2d9806fe582de24f2570b36726000c48270ba9ab'

  # config.allow_unconfirmed_access_for = 2.days

  # config.confirm_within = 3.days

  config.reconfirmable = true

  config.confirmation_keys = [ :username ]

  config.remember_for = 2.weeks

  config.expire_all_remember_me_on_sign_out = true

  # config.extend_remember_period = false

  # config.rememberable_options = {}

  config.password_length = 8..128

  # config.email_regexp = /\A[^@]+@[^@]+\z/

  # config.timeout_in = 30.minutes

  # config.expire_auth_token_on_timeout = false

  # config.lock_strategy = :failed_attempts

  # config.unlock_keys = [ :email ]

  # :email = Sends an unlock link to the user email
  # :time  = Re-enables login after a certain amount of time (see :unlock_in below)
  # :both  = Enables both strategies
  # :none  = No unlock strategy. You should handle unlocking by yourself.
  # config.unlock_strategy = :both

  # config.maximum_attempts = 20

  # config.unlock_in = 1.hour

  # config.last_attempt_warning = true

  config.reset_password_keys = [ :username ]

  config.reset_password_within = 6.hours

  # config.encryptor = :sha512

  # config.scoped_views = false

  # config.default_scope = :user

  # config.sign_out_all_scopes = true

  config.sign_out_via = :delete

  # config.omniauth :github, 'APP_ID', 'APP_SECRET', scope: 'user,public_repo'

  # config.warden do |manager|
  #   manager.intercept_401 = false
  #   manager.default_strategies(scope: :user).unshift :some_external_strategy
  # end

  # config.router_name = :my_engine
  # config.omniauth_path_prefix = '/my_engine/users/auth'
end
