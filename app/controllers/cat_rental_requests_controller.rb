class CatRentalRequestsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @cat_rental_requests = CatRentalRequest.includes(:cat).order(:begin_date)
    render :index
  end

  def create
    @cat_rental_request = CatRentalRequest.create!(params[:cat_rental_request])
    if @cat_rental_request
      redirect_to cat_rental_request_url(@cat_rental_request)
    else
      render :text => "Cat rental request failed.  Try again, human.", :status => :unprocessable_entity
    end
  end

  def show
    @cat_rental_request = CatRentalRequest.find(params[:id])
    render :show
  end

  def update
    @cat_rental_request = CatRentalRequest.find(params[:id])

    if params[:cat_rental_request][:status] == 'approved'
      @cat_rental_request.approve
    else
      @cat_rental_request.update_attributes(params[:cat_rental_request])
      @cat_rental_request.save!
    end

    render :show
  end
end
