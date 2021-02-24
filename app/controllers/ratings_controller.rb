# Creates new and update for rating
class RatingsController < ApplicationController
  before_action :find_film
  before_action :find_rating, only: %i[update]

  def new
    @rating = Rating.new
  end

  def create
    @rating = Rating.new(rating_params)
    @rating.film_id = @film.id

    if @rating.save
      redirect_to @film
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @rating.update
      redirect_to @film
    else
      render 'edit'
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:user_rating)
  end

  def find_rating
    @rating = Rating.find(params[:id])
  end

  def find_film
    @film = Film.find(params[:film_id])
  end
end