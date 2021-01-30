class EventsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @user = User.find(session[:current_user_id])
    # Can't create event through the association, because then how would I get the event to render
    # But also cant create the event first, because it needs to be created with the host_id
    @event = Event.new(event_params)
    @user.hostedevents << @event
    if @event.save
    #if @user.hostedevents.create(event_params)
      flash[:notice] = "Successfully created event"
      redirect_to @event
    else
      flash.now[:error] = "Failed to create event"
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  private 

  def require_login
    if !session[:current_user_id]
      flash[:error] = "You must be logged in to access this section"
      redirect_to "/users/new"
    end
  end 

  def event_params
    params.require(:event).permit(:name, :date, :location)
  end
end
