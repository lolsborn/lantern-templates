class Api::V1::UsersController < Api::V1::BaseController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    pagy, users = pagy(User.all.order(:created_at))
    render_collection(users, UserSerializer, pagy)
  end

  def show
    render_resource(@user, UserSerializer)
  end

  def create
    user = User.new(user_params)

    if user.save
      render_resource(user, UserSerializer, :created)
    else
      render json: {
        error: 'Validation failed',
        details: user.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render_resource(@user, UserSerializer)
    else
      render json: {
        error: 'Validation failed',
        details: @user.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  def me
    render_resource(current_user, UserSerializer)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end
end