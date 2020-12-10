class UpdatePasswordForm
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :new_password, :new_password_confirmation

  validate :verify_passwords
  validates_presence_of :new_password, :new_password_confirmation
  validates_confirmation_of :new_password
  validates_length_of :new_password, { minimum: 5 }

  def initialize(user)
    @user = user;
  end

  def submit(params)
    self.new_password = params[:new_password]
    self.new_password_confirmation = params[:new_password_confirmation]
    if valid?
      @user.password = new_password
      @user.save!
      true
    else
      false
    end
  end

  def verify_passwords
    unless new_password == new_password_confirmation
      errors.add :new_password, 'Passwords do not match.'
    end
  end
end