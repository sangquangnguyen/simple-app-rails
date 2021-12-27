class SessionsController < ApplicationController
  def new; end

  def create
    @user = Employee.find_by(email: params[:session][:email].downcase)

    if @user.present? && @user.password.is_password?(params[:session][:password])
      if @user.verified
        # sets up user.id sessions
        session[:user_id] = @user.id
        redirect_to root_path, notice: 'Logged in successfully'
      else
        flash[:danger] = 'Account has not been verified yet'
        render :new
      end
    else
      flash[:danger] = 'Invalid email or password'
      render :new
    end
  end

  def destroy
    # deletes user session
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged Out'
  end

  def about
    @user = Employee.last
    render 'sessions/about'
  end
end
