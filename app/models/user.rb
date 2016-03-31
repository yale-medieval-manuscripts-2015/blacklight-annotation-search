class User < ActiveRecord::Base
# Connects this users object to Blacklights Bookmarks.
 include Blacklight::User
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:cas]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :encrypted_password, :password_confirmation, :remember_me, :provider, :uid, :name
  # attr_accessible :title, :body

  # Omniauth
  # attr_accessible :provider, :uid, :name

 # Method added by Blacklight; Blacklight uses #to_s on your
  # users class to get a users-displayable login/identifier for
  # the account. 
  def to_s
    email
  end
end
