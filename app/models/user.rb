class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :wikis
  has_many :collaborators
  has_many :private_wikis, through: :collaborators, source: :wiki
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :wikis, dependent: :destroy
  enum role: [:admin, :standard, :premium]
  after_initialize :set_default_role, if: :new_record?
  after_create :send_confirm_email

  def set_default_role
    self.role ||= :standard
  end


  private

  def send_confirm_email
    ConfirmMailer.confirm_mail(self).deliver_now
  end

  def self.all_except(user)
    where.not(id: user)
  end
end
