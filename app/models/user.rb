class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: { reader: 0, admin: 1, user: 2 }

  before_save :purge_avatar, if: :avatar_changed?

  has_one_attached :avatar

  has_many :posts
  has_many :comments

   validates :name, presence: true, uniqueness: true
   validates :email, presence: true, uniqueness: true
   validates :role, presence: true

  def avatar_url
    if avatar.attached?
      Rails.application.routes.url_helpers.rails_blob_url(avatar, only_path: true)
    else
      "https://ui-avatars.com/api/?name=#{CGI.escape(name)}&background=random&color=ffffff&size=150"
    end
  end

  private

  def avatar_changed?
    avatar.attached? && avatar.changed?
  end

  def purge_avatar
    avatar.purge_later
  end
end
