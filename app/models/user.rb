class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable , :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username,
    :presence => true,
    :uniqueness => {
      :case_sensitive => false
    }

  attr_accessor: login

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      conditions[:email].downcase! if conditions[:email]
      where(conditions.to_h).where(
		["lower(username) = :value OR lower(email)"])
    else
      where(conditions.to_h).first
    end 
  end

end
