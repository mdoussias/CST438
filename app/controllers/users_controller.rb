class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    if !current_user
      @user = User.new
    else
      flash[:danger] = 'Not permitted, log out first'
      redirect_to root_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        log_in @user
        flash[:success] = "Welcome to Expense Tracker "
        format.html {redirect_to @user}
        format.json {render :show, status: :created, location: @user}
      else
        format.html {render :new}
        format.json {render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation,:email)
  end

  def expenses_json
    user = User.find_by email: params[:email]
    @expenses = Expense.where(user_id: user.id)
  end

end
