class User < ApplicationRecord
  extend Devise::Models
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [:login]
  has_many :movie_reviews
  has_many :favorites
  has_many :favorited_movies, through: :favorites, source: :filme
  # validates :titulo, presence: { message: "não pode ser deixado em branco" }


  attr_accessor :login

   # Validar presença de login (e-mail ou username)
  #  validates :login, presence: true, uniqueness: { case_sensitive: false }

   # Sobrescrever método de autenticação para suportar login por e-mail ou username
   def self.find_for_database_authentication(warden_conditions)
     conditions = warden_conditions.dup
     login = conditions.delete(:login)
     where(conditions.to_h).where(["lower(email) = :value OR lower(username) = :value", { value: login.downcase }]).first
   end

  def has_reviewed?(filme)
    movie_reviews.exists?(filme: filme)
  end
end
