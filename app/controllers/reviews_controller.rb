class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new(review_params)
    # we need `restaurant_id` to asssociate review with corresponding restaurant
    respond_to do |format|
      if @review.save
        @review.restaurant = Restaurant.find(params[:restaurant_id])
        format.html { redirect_to @restaurant, notice: 'Review was successfully updated.' }
      else
        format.html { render :new }
      end
    end

  end

  private

  def review_params
    params.require(:review).permit(:content, :rating, :restaurant_id)
  end
end
