class UsersController < ApplicationController
  #ぷろふぃーるの表示画面
  def profile
  end
  
  #プロフィールの編集画面
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "プロフィールを更新しました"
      redirect_to profile_path
    else
      flash.now[:notice] = "プロフィールの更新ができませんでした"
      render "edit"
    end
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :introduction, :image)
    end
end
