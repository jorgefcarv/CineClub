class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favoritos = current_user.favorited_movies
  end
  
end
