class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: 'Usuario creado exitosamente.'
    else
      flash.now[:error] = 'Hubo un error al crear el usuario.'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :image)
  end
end
