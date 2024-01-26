class BrightEventsController < ApplicationController
  def index
    @events = BrightEvent.all
  end

  def show
    @event = BrightEvent.find(params[:id])
  end

  def new
    @events = BrightEvent.new
  end

  def create
    @events = BrightEvent.new(event_params)

    if @events.save
      redirect_to bright_events_path
    else
      flash[:error] = @events.errors.full_messages.to_sentence
      redirect_to new_bright_event_path
    end
  end

  def edit
    @events = BrightEvent.find(params[:id])
  end

  def update
    @events = BrightEvent.find(params[:id])

    if @events.update(event_params)
      redirect_to bright_event_path
    else
      flash[:error] = @events.errors.full_messages.to_sentence
      redirect_to edit_bright_event_path
    end
  end

  def destroy
    @events = BrightEvent.find(params[:id])
    @events.destroy

    redirect_to bright_events_path
  end

  private

  def event_params
    params.require(:bright_event).permit(:title, :description, :date, :ubication, :cost)
  end
end
