class Filme < ApplicationRecord
    has_many :movie_reviews
    has_many :favorites
    has_many :favorited_by, through: :favorites, source: :user
    validates :ano_lancamento, :titulo, :diretores, :produtora, presence: { message: "não pode ser deixado em branco" }

    # filme = Filme.find(1)
    # avaliacoes = filme.movie_reviews

    def calcular_media_notas
        return 0 if movie_reviews.empty?
    
        total_notas = movie_reviews.sum(:rating)
        total_notas.to_f / movie_reviews.count
      end
end
  