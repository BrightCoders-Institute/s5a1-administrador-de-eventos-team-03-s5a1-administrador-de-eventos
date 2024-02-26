class BrightEventsController < ApplicationController
  before_action :find_event, only: %i[show edit update destroy purge_image]

  def index
    @events = BrightEvent.all_events(current_user).page params[:page]
    filters if filters?
    download_csv if params[:format] == 'csv'
  end

  def show; end

  def new
    @event = BrightEvent.new
  end

  def user_events
    @events = current_user.bright_events.page params[:page]
    filters if filters?
    download_csv if params[:format] == 'csv'
  end

  def create
    @event = current_user.bright_events.create(event_params)

    if @event.save
      EventReminderJob.set(wait_until: @event.reminder).perform_later(@event.id, @event.updated_at)
      redirect_to user_bright_events_path
    else
      flash[:error] = @event.errors.full_messages.to_sentence
      redirect_to new_bright_event_path
    end
  end

  def edit; end

  def purge_image
    @event.image.destroy
    redirect_back fallback_location: edit_bright_event_path(@event.id), notice: 'Imagen eliminada con éxito'
  end

  def update
    if @event.update(event_params)
      EventReminderJob.set(wait_until: @event.reminder).perform_later(@event.id, @event.updated_at)
      redirect_to user_bright_events_path
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

  def filters
    @events = @events.filter_date(params[:date_from], params[:date_to]) if date_filter?
    if params[:privacy] == 'Todos' && params[:privacy].present?
      @events = @events.all_events(current_user)
    elsif params[:privacy] == 'true' && params[:privacy].present?
      @events = current_user.bright_events.where(privacy: true).page params[:page]
    elsif params[:privacy] == 'false' && params[:privacy].present?
      @events = @events.where(privacy: params[:privacy])

      @events
    end

    @events
  end

  def event_params
    params.require(:bright_event).permit(:title, :description, :date, :location, :cost, :image, :privacy, :reminder)
  end

  def date_filter?
    params[:date_from].present? && params[:date_to].present?
  end

  def filters?
    params[:date_from].present? || params[:date_to].present? || params[:privacy].present?
  end

  def find_event
    @event = BrightEvent.find(params[:id])
  end

  def download_csv
    respond_to do |format|
      format.html
      format.csv { send_data BrightEvent.to_csv(@events), filename: "eventos-#{Date.today}.csv" }
    end
  end
end
