class EventsController < ApplicationController
  def index
    @event = Event.new
    @user = User.find(session[:user_id])
    @local_events = Event.where("state =?", @user.state).order("date DESC")
    @other_events = Event.where("state !=?", @user.state).order("date DESC")
    @attending = @user.attending
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
    @event = Event.find(params[:id])
    @attendees = EventAttendee.where("event_id = ?", @event.id)
    @comments = Comment.where("event_id = ?", @event.id).order("created_at DESC")
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.update(name: params[:name], date: params[:date], city: params[:city], state: params[:state])
    if @event.save
      redirect_to events_path
    else
      flash[:notice] = @event.errors.full_messages
      redirect_to :back
    end
  end

  def join_event
    EventAttendee.create(event_id: params[:id], user_id: session[:user_id])
    redirect_to :back
  end

  def leave_event
    @event = EventAttendee.find_by("event_id = ? AND user_id = ?", params[:id], session[:user_id])
    @event.destroy
    redirect_to :back
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
  end

  protected
    def event_params
      params.require(:event).permit(:name, :date, :city, :state)
    end
end
