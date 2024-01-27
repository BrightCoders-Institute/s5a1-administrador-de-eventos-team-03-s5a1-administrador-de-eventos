class BrightEventsController < ApplicationController
  before_action :find_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = BrightEvent.all
  end

  def show
    @event = find_event
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
    @events = find_event
  end

  def update
    @events = find_event

    if @events.update(event_params)
      redirect_to bright_event_path
    else
      flash[:error] = @events.errors.full_messages.to_sentence
      redirect_to edit_bright_event_path
    end
  end

  def destroy
    @events = find_event
    @events.destroy

    redirect_to bright_events_path
  end

  private

  def event_params
    params.require(:bright_event).permit(:title, :description, :date, :ubication, :cost)
  end

  def find_event
    BrightEvent.find(params[:id])
  end
end