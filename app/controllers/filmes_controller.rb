class FilmesController < ApplicationController
  before_action :set_filme, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /filmes or /filmes.json
  def index
    @filmes = Filme.all
    @filmes_classificados = Filme.includes(:movie_reviews).where.not(movie_reviews: { rating: nil })    
    
    @filmes = Filme.joins(:movie_reviews)

  end
  
  # GET /filmes/1 or /filmes/1.json
  def show
  end

  # GET /filmes/new
  def new
    @filme = Filme.new
  end

  # GET /filmes/1/edit
  def edit
  end

  # POST /filmes or /filmes.json
  def create
    @filme = Filme.new(filme_params)

    respond_to do |format|
      if @filme.save
        format.html { redirect_to registered_movie_path, notice: "Filme was successfully created." }
        format.json { render :show, status: :created, location: @filme }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @filme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filmes/1 or /filmes/1.json
  def update
    respond_to do |format|
      if @filme.update(filme_params)
        format.html { redirect_to filme_url(@filme), notice: "Filme was successfully updated." }
        format.json { render :show, status: :ok, location: @filme }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @filme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filmes/1 or /filmes/1.json
  def destroy
    @filme.destroy!

    respond_to do |format|
      format.html { redirect_to filmes_url, notice: "Filme was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def avaliar
    @filme = Filme.find(params[:id])
    @movie_review = @filme.movie_reviews.new
  end

  def save_avaliacao
    @filme = Filme.find(params[:id])
    @movie_review = @filme.movie_reviews.new(movie_review_params)
  
    if @movie_review.save
      redirect_to filme_avaliacoes_path(@filme)
    else
      render :avaliar
    end
  end

  def avaliacoes
    @filme = Filme.find(params[:id])
    @avaliacoes = @filme.movie_reviews
  end

  def todos_filmes
    if params[:search]
      @filmes = Filme.where("titulo ILIKE ? OR diretores ILIKE ? OR produtora ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
    else
      @filmes = Filme.all
    end
  end

  def favoritar
    filme = Filme.find(params[:id])
    current_user.favorites.create(filme: filme)
    redirect_to todos_filmes_path, notice: 'filme favoritado com sucesso.'
  end

  def desfavoritar
    filme = Filme.find(params[:id]) 
    current_user.favorites.find_by(filme: filme).destroy
    redirect_to todos_filmes_path, notice: 'filme removido dos favoritos.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filme
      @filme = Filme.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def filme_params
      params.require(:filme).permit(:imagem_nome, :imagem_caminho, :titulo, :diretores, :ano_lancamento, :nota, :produtora, :opiniao, :idiomas, :genero)
    end
end
