class User < ActiveRecord::Base
  has_secure_password

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, presence: true, length: { in: 2..20 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :password, presence: true, length: { minimum:8 }, on: :create

  before_save :email_lowercase, :name_cap
  after_create :successfully_created

  before_update :skip_password_attribute
  after_update :successfully_updated

private
  def email_lowercase
    email.downcase!
  end

  def successfully_created
    puts "Successfully created a new User"
  end

  def successfully_updated
    puts "Successfully updated"
  end

  def skip_password_attribute
    if :password.blank? && :password_confirmation.blank?
     params.except!(:password, :password_confirmation)
    end
  end

  def name_cap
    first_name.capitalize!
    last_name.capitalize!
  end

end
