class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  # Return first and last name
  def full_name
    if self.first_name.present? && self.last_name.present?
      "#{first_name} #{last_name}".better_titlecase
    end
  end

  def self.from_omniauth(auth_token)
    data = auth_token.info
    user = User.where(email: data['email']).first

    # Create user if doesn't exist
    unless user
        user = User.create(
            first_name: data['first_name'],
            last_name: data['last_name'],
            email: data['email'],
            password: Devise.friendly_token[0,20],
            avatar_url: data['image']
        )
    end
    user
  end
end