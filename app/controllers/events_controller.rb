class EventsController < ApplicationController
  def index
    @event = Event.new
    @user = User.find(session[:user_id])
    @local_events = Event.where("state =?", @user.state).order("date DESC")
    @other_events = Event.where("state !=?", @user.state).order("date DESC")
    @attendees = EventAttendee.all
  end

  def create
    @event = Event.new(event_params)
    @event.host_id = session[:user_id]
    if @event.save
      redirect_to :back
    else
      flash[:notice] = @event.errors.full_messages
      redirect_to :back
    end
  end

  def show
  end

  def edit
  end

  protected
    def event_params
      params.require(:event).permit(:name, :date, :city, :state)
    end
end
