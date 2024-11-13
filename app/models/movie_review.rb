class MovieReview < ApplicationRecord
  belongs_to :filme
  belongs_to :user

  validates :filme_id, uniqueness: { scope: :user_id, message: "Usuário já classificou este filme" }
  # validates :rating, resence: { message: "A nota não pode ser nula" }, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :rating, presence: { message: "A nota não pode ser nula" },
                   numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }  

end
 