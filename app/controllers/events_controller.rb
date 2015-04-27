class EventsController < ApplicationController

  require 'event_form_filler'

  before_filter :current_user

  def index
    @events = []
    @dogs = current_user.dogs
    @dogs.each do |dog|
      (@events << dog.events).flatten!

    end
  end

  def show
    id = params[:id]
    @event = Event.find(id)
    redirect_to dog_path(@event.dog_id)
  end

  def new
    @form_filler = EventViewHelper.new(current_user)
    @action = :create
    @method = :post

    unless @form_filler.all_dogs != []
      flash[:notice] = "Please create a dog to share"
      redirect_to user_path(current_user.id)
    end
  end


  def create
    @form_filler = EventViewHelper.new(current_user)
    @event_attr = @form_filler.event_info(params)
    @dogs = @form_filler.dogs
    set_flash

    if flash[:notice]
      render 'new'
    else
      redirect_to events_path
    end
  end


  def edit
    @event = Event.find(params[:id])
    @dog = Dog.find(@event.dog_id)
    @form_filler = EventViewHelper.new(current_user)
    @form_filler.event_view_update(@event)
    @action = :update
    @method = :put
  end



  def update
    @event = Event.find(params[:id])
    @dog = Dog.find(@event.dog_id)    

    @form_filler = EventViewHelper.new(current_user)
    @event_attr = @form_filler.event_info(params)
    @event_attr[:dog] = @dog
    if @event.update_attributes(@event_attr)
      redirect_to events_path
    else
      flash[:notice] = @event.errors.messages
      redirect_to edit_event_path(params[:id])
    end
  end


  def destroy
    @event = Event.find(params[:id])
    @event.delete
    flash[:notice] = "Your event has been deleted."
    redirect_to events_path
  end


  def set_flash
    if @dogs.empty?
      flash[:notice] = {:name => ["Please select a dog to share"]}
    elsif not create_events
      flash[:notice] = @event.errors.messages
    end
  end


  def create_events
    @dogs.each do |dog|
      @event_attr[:dog] = current_user.dogs.find_by_name(dog)
      @event = Event.new(@event_attr)
      if not @event.valid?
        return false
      else
        @event.save
      end
    end
  end


end

