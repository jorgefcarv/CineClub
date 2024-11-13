class MovieReviewsController < ApplicationController
  before_action :authenticate_user!

    def index
      if params[:search]
        @filmes = Filme.where("titulo LIKE ? OR diretores LIKE ? OR produtora LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
      else
        @filmes = Filme.all
      end
    end

    def show
      @filme = Filme.find(params[:id])
      @movie_review = MovieReview.new
      @reviews = @filme.movie_reviews
    end

    def create
      @filme = Filme.find(params[:movie_review][:filme_id])
      if current_user.has_reviewed?(@filme)
        redirect_to @filme, notice: "Você já classificou este filme"
      else
        @review = MovieReview.new(review_params)
        @review.user = current_user
  
        if @review.save
          redirect_to @filme, notice: "filme classificado com sucesso"
        else
          render :new
        end
      end
    end

    private
  
    def review_params
      params.require(:movie_review).permit(:filme_id, :rating, :opinion)
    end
  end
  