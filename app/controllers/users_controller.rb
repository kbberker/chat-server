class UsersController < ApplicationController

  def index
    users = User.all
    render json: users
  end

  def create
    user = User.create(username: params[:username], password: params[:password], name: params[:name])
    if user.valid?
      # serialized_data = ActiveModelSerializers::Adapter::Json.new(
      #   UserSerializer.new(user)
      # ).serializable_hash
      #
      # head :ok
      render json: user
    else
      render json: {error: "SOMETHING WENT WRONG CREATING USER"}
    end

  end

  def login
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      render json: user
    else
      render json: {error: "Cannot find or authenticate user. Loseeeeeerrr"}
    end
  end

  private

  def users_params
    params.require(:user).permit(:name, :username, :password)
  end

end