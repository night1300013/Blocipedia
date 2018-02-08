class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :wikis, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :wikis, dependent: :destroy
  enum role: [:admin, :standard, :premium]
  after_initialize :set_default_role, if: :new_record?
  after_create :send_confirm_email

  def set_default_role
    self.role ||= :standard
  end

  def make_wikis_public!
    self.wikis.update(private: false)
  end

  private

  def send_confirm_email
    ConfirmMailer.confirm_mail(self).deliver_now
  end

end
