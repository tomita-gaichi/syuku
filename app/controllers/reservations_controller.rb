class ReservationsController < ApplicationController

  before_action :authenticate_user!, except: [:rooms]

  def index
  end

  def new
    @post = Post.find(params[:id])
    @reservation = Reservation.new
    @reservation = Reservation.find(params[:id])
  end

  def kari
    @reservation = Reservation.find(params[:id])
  end
  
  def create
    @post = Post.find(params[:post_id])
    @reservation = Reservation.new(**reservation_params, user_id: current_user.id, post_id:@post.id)
    respond_to do |format|
      if @reservation.save
        format.html {redirect_to reservations_kari_path(@reservation.id), notice: '予約しました'}
      else
        format.html {render "reservations/#{@reservation.id}/rooms"}
      end
    end
  end

  def reshow
    @reservations = Reservation.where(user_id:current_user.id)
  end

  def rooms
    @post = Post.find(params[:id])
    @reservation = Reservation.new 
  end

  private
    def reservation_params
      params.require(:reservation).permit(:start_date, :end_date, :person, :confirming)
    end

end
