class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :validatable,  :recoverable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable , :registerable,
         :rememberable, :trackable, :validatable, :recoverable,
	 :authentication_keys => [:username]

end
