# frozen_string_literal: true

# Creates new and update for rating
class RatingsController < ApplicationController
  include SessionsHelper
  before_action :find_film
  before_action :find_rating, only: %i[update]

  def new
    @rating = @film.ratings.new
  end

  def create
    @rating = Rating.new(rating_params)
    @rating.film_id = @film.id
    @rating.user_id = current_user.id

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
