module Admin
  class UsersController < BaseController
    before_action :set_user, only: [:show, :edit, :update]

    def index
      @users = User.order(:name)
    end

    def show
    end

    def edit
    end

    def update
      if @user.update(user_params)
        redirect_to admin_user_path(@user), notice: "ユーザー情報を更新しました"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :role)
    end
  end
end
