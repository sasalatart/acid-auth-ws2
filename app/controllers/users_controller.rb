class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: 'Usuario creado exitosamente.'
    else
      flash.now[:alert] = @user.human_errors
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(update_params)
      redirect_to users_path, notice: 'Usuario actualizado exitosamente.'
    else
      flash.now[:alert] = @user.human_errors
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: 'Se eliminó al usuario exitosamente.'
  end

  def verify
    res = VerificationService.check_biometry(params[:email], params[:image])

    if res[:status] == 200
      UserMailer.notify_login(params[:email], request.user_agent).deliver
    end

    render json: { message: res[:message] }, status: res[:status]
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def update_params
    params.require(:user).permit(:image)
  end

  def user_params
    params.require(:user).permit(:email, :image)
  end
end
