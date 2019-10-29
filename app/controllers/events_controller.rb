class EventsController < ApplicationController
  #event/index
  #event
  def index
    @events = Event.all
  end

  # event/new
  def new
    @event = Event.new
  end

  def create
    @event = Event.new( event_pararms )
    @event.save
    redirect_to :action => :index #HTTP 303
  end

  private def event_pararms
    params.require(:event).permit(:name , :description)
  end  
  
  #event/show/:id
  def show 
    @event = Event.find( params[:id] )
  end

  #event/edit/id
  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_pararms)
    redirect_to :action => :show, :id => @event
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to :action => :index
  end

end
