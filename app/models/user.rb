class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatables

  validates :name, presence: true

  has_many :prototypes
  has_many :likes
  has_many :comments
end
