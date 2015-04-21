class DogsController < ApplicationController

  require 'dog_form_filler'

  before_filter :current_user

  def index

    ip_zipcode = get_ip_address_zipcode
    @form_filler = DogViewHelper.new(current_user, ip_zipcode, true)
    @form_filler.update_values(params, ip_zipcode, current_user)

    @dogs = Dog.filter_by @form_filler.values
    @no_dogs = @dogs.empty?

    @zipcodes = get_zipcode_from_dogs
    @counts = get_zipcode_counts.to_json
  end

  def get_ip_address_zipcode
    request.safe_location.postal_code
  end

  def new
    @form_filler = DogViewHelper.new(nil, nil, false)
    @action = :create
    @method = :post

    unless current_user.zipcode != nil and current_user.zipcode != "" 
      flash[:notice] = "Please update your zipcode to add a dog."
      redirect_to edit_user_path(current_user)
    end
  end


  def show
    id = params[:id]
    @dog = Dog.find(id)
    @parent = User.find(@dog.user_id)
  end

  def create
    @form_filler = DogViewHelper.new(nil, nil, false)
    @dog = Dog.new(@form_filler.attributes_list(params['dog']))
    @dog.user_id = current_user.id

    if @dog.save
      redirect_to user_path(current_user)
    else
      flash[:notice] = @dog.errors.messages
      render 'new'
    end
  end

  def edit 
    @form_filler = DogViewHelper.new(nil, nil, false)
    @dog = Dog.find(params[:id])
    @form_filler.dog_view_update(@dog)
    @action = :update
    @method = :put
  end

  def update
    @form_filler = DogViewHelper.new(nil, nil, false)
    @dog = Dog.find(params[:id])

    if @dog.update_attributes(@form_filler.attributes_list(params['dog']))
      redirect_to dog_path(@dog.id)
    else
      flash[:notice] = @dog.errors.messages
      redirect_to edit_dog_path(@dog.id)
    end
  end

  def destroy
    @dog = Dog.find(params[:id])
    @dog.delete
    redirect_to user_path(@current_user)
  end

  def get_zipcode_from_dogs
    @dogs.collect{|dog| dog.address}
  end

  def get_zipcode_counts
    wf = Hash.new(0)
    @zipcodes.each{|word| wf[word] += 1}
    wf
  end

end


