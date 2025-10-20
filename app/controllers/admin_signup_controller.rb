class AdminSignupController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.role = 'admin'

    if @user.save
      sign_in(@user)
      redirect_to admin_dashboard_path, notice: 'Administrador cadastrado e autenticado com sucesso!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

