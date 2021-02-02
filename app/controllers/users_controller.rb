class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:current_user_id] = @user.id
      redirect_to @user
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @hostedevents = @user.hostedevents

    attended_events = @user.attended_events
    @previously_attended_events = attended_events.where("date < ?", Date.today)
    @upcoming_events = attended_events - @previously_attended_events
  end

  def signin
    begin
      @user = User.find_by!(user_params)
    rescue ActiveRecord::RecordNotFound
      flash.now[:error] = "Invalid user name"
      render
    else
      flash[:notice] = "Successfully signed in"
      session[:current_user_id] = @user.id
      redirect_to "/events"
    end
  end

  def signout
    session.delete(:current_user_id)
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name)
  end
end
