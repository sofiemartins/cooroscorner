class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :validatable,  :recoverable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable , :registerable,
         :rememberable, :trackable, :validatable,
	 :authentication_keys => [:username]

  attr_accessor :username

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:username)
      where(conditions).where(["username = :value OR lower(:value)", { :value => login }]).first
    else
      where(conditions).first
    end
  end
 
  validates :username, presence: true, length: {maximum: 10}, uniqueness: { case_sensitive: false }

end
