class EventsController < ApplicationController
  
  before_action :set_event, :only => [ :show, :edit, :update, :destroy ]
  #event/index
  #event
  def index
    @events = Event.page(params[:page]).per(50)

    respond_to do |format|
      format.html
      format.xml {
        render :xml => @event.to_xml
      }
      format.json{
        render :json => @event.to_json
      }
      format.atom{
        @feed_title = "My event list"
      }# index.atom.builder
    end
  end

  # event/new
  def new
    @event = Event.new
  end

  def create
    @event = Event.new( event_pararms )
    if @event.save
      flash[:notice] = "新增成功"
      #redirect_to :action => :index #HTTP 303
      redirect_to events_url
    else
      render :action => :new
    end
  end 
  
  #event/show/:id
  def show 
    #@event = Event.find( params[:id] )
    @page_title = @event.name
    respond_to do |format|
      format.html { @page_title = @event.name } # show.html.erb
      format.xml # show.xml.builder
      format.json { render :json => { id: @event.id, name: @event.name }.to_json }
    end
  end

  #event/edit/id
  def edit
    #@event = Event.find(params[:id])
  end

  def update
    #@event = Event.find(params[:id])
    if @event.update(event_pararms)
      flash[:notice] = "更改成功"
      #redirect_to :action => :show, :id => @event
      redirect_to event_url(@event)
    else
      render :action => :edit
    end
  end

  def destroy
    #@event = Event.find(params[:id])
    @event.destroy
    flash[:alert] = "删除成功"
    redirect_to :action => :index
  end

  private
  def event_pararms
    params.require(:event).permit(:name , :description)
  end
  
  def set_event
    @event = Event.find(params[:id])
  end
end
