class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:own, :new, :create, :edit, :update, :destroy]
  
  # 自分の登録した施設一覧を表示する画面
  def own
    @rooms = current_user.rooms
  end

  # 施設の新規登録画面
  def new
    @room = Room.new
  end

  # 施設の新規登録処理
  def create
    @room = Room.new(room_params)
    if @room.save
      flash[:notice] = "施設の新規登録が完了しました"
      redirect_to :room_own
    else
      flash[:notice] = "施設の新規登録に失敗しました"
      render "new"
    end
  end

  # 施設の詳細ページ
  def show
    @room = Room.find(params[:id])
    @reservation = Reservation.new
  end

  #　施設情報の編集ページ
  def edit
    @room = Room.find(params[:id])
  end

  #　施設情報の編集処理
  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      flash[:notice] = "施設情報の編集が完了しました"
      redirect_to :room_own
    else
      flash[:notice] = "施設情報の編集に失敗しました"
      render "new"
    end
  end

  #　施設情報の削除処理
  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    flash[:notice] = "施設情報を削除しました"
    redirect_to :room_own
  end

  # 施設の検索結果表示ページ
  def index
    if params[:keyword]
      @rooms = Room.search(params[:keyword])
    elsif params[:area_keyword]
      @rooms = Room.area_search(params[:area_keyword])
    end
  end

  private

    def room_params
      params.require(:room).permit(:room_name, :room_image, :room_introduction, :price, :address, :user_id)
    end
end
