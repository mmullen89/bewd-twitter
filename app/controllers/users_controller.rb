class UsersController < ApplicationController
  def create
    @user = User.new(task_params)
    if @user.save
      render 'users/create'
    end
  end

  private
    def task_params
      params.require(:user).permit(:username, :email, :password)
    end

end
