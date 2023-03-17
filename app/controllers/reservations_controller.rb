class ReservationsController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @reservations = Reservation.where(user_id:current_user.id)
  end

  def confirm
    @reservation = Reservation.new(reservation_params)
    @room = Room.find(params[:room_id])
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @room = Room.find(params[:room_id])
    if @reservation.save
      redirect_to :reservations
    else
      render 'room/show'
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
    @room = @reservation.room
  end

  def update
    @reservation = Reservation.find(params[:id])
    @room = @reservation.room
    if @reservation.update(reservation_params)
      flash[:notice] = "再予約を行いました"
      redirect_to :reservations
    else
      flash.now[:notice] = "再予約に失敗しました"
      render "edit"
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    flash[:notice] = "予約を取り消しました"
    redirect_to :reservations
  end

  private
    def reservation_params
      params.require(:reservation).permit(:check_in, :check_out, :number_of_people, :user_id, :room_id)
    end
end
