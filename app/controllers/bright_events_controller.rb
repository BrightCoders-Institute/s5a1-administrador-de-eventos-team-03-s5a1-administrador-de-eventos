class BrightEventsController < ApplicationController
  before_action :find_event, only: %i[show edit update destroy purge_image]

  def index
    @events = BrightEvent.all
  end

  def show() end

  def new
    @event = BrightEvent.new
  end

  def user_events
    @events = current_user.bright_events
  end

  def create
    @event = current_user.bright_events.create(event_params)

    if @event.save
      redirect_to user_bright_events_path
    else
      flash[:error] = @event.errors.full_messages.to_sentence
      redirect_to new_bright_event_path
    end
  end

  def edit() end

  def purge_image
    @event.image.destroy
    redirect_back fallback_location: edit_bright_event_path(@event.id), notice: 'Imagen eliminada con éxito'
  end

  def update
    if @event.update(event_params)
      redirect_to bright_events_path
    else
      flash[:error] = @event.errors.full_messages.to_sentence
      redirect_to edit_bright_event_path
    end
  end

  def destroy
    @event.destroy

    redirect_to bright_events_path
  end

  private

  def event_params
    params.require(:bright_event).permit(:title, :description, :date, :location, :cost, :image)
  end

  def find_event
    @event = BrightEvent.find(params[:id])
  end
end
