class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :authorize_user, only: [:show]


  def show
    @horses = @user.horses
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user
    unless current_user == @user
      redirect_to root_path, alert: "You are not authorized to view this page."
    end
  end

end
