class DogsController < ApplicationController

  require 'dog_form_filler'

  before_filter :current_user

  def index

    @form_filler = DogFormFiller.new(current_user, request)
    @form_filler.update_values(params, request, current_user)
    @dogs = Dog.filter_by @form_filler.values
    @no_dogs = @dogs.empty?

    @zipcodes = get_zipcode_from_dogs
    @counts = get_zipcode_counts.to_json
  end


  def new
    @form_filler = DogFormFiller.new(current_user, request)
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
  end

  def create
    @form_filler = DogFormFiller.new(current_user, request)
    @dog = Dog.new(@form_filler.attributes_list(params))
    @dog.user_id = current_user.id
    if @dog.save
      redirect_to user_path(current_user)
    else
      # set_vars_for_render(params['dog'])
      flash[:notice] = @dog.errors.messages
      render 'new'
    end
  end

  def edit 
    @form_filler = DogFormFiller.new(current_user, request)
    @dog = Dog.find(params[:id])
    @form_filler.dog_view_update(@dog)
    @action = :update
    @method = :put
  end

  def update
    @form_filler = DogFormFiller.new(current_user, request)
    @dog = Dog.find(params[:id])
    if @dog.update_attributes(@form_filler.attributes_list(params))
      redirect_to dog_path(@dog.id)
    else
      # set_vars_for_render(params['dog'])
      flash[:notice] = @dog.errors.messages
      redirect_to edit_dog_path(@dog.id)
    end
  end

  def destroy
    @dog = Dog.find(params[:id])
    @dog.delete
    redirect_to user_path(@current_user)
  end


  # def set_vars
  #   @likes = Like.pluck(:value)  
  #   @personalities = Personality.pluck(:value)
  # end

  # def set_vars_for_render(dog_attributes)
  #   set_vars
  #   @checked_personalities = dog_attributes['personalities'] ? dog_attributes['personalities'].keys  : []
  #   @checked_likes = dog_attributes['likes'] ? dog_attributes['likes'].keys : []
  #   @size = dog_attributes['size']
  #   @energy_level = dog_attributes['energy_level']
  #   @mixes = dog_attributes['mixes'].split(',')
  # end

  def get_zipcode_from_dogs
    @dogs.collect{|dog| dog.address}
  end

  def get_zipcode_counts
    wf = Hash.new(0)
    @zipcodes.each{|word| wf[word] += 1}
    wf
  end

  # def get_checkbox_selections(criteria, default)
  #   if params[criteria]
  #     return params[criteria].keys()
  #   else
  #     return default
  #   end
  # end


  # def get_mix_array(mix_string)
  #   tags = mix_string.split(",")
  #   tags.map{ |tag| Mix.find_by_value(tag) }
  # end


  # def get_attribute_array(attributes, trait)
  #   if attributes[trait] != nil
  #     model_class = trait.classify.constantize
  #     attributes[trait].keys.map { |thing| model_class.find_by_value(thing) }
  #   else
  #     return []
  #   end
  # end

  # def get_dropdown_selection(criteria, default)
  #   if params[criteria]
  #     return params[criteria]
  #   else
  #     return default
  #   end
  # end



  # def filter_dogs
  #   filter_criteria = {}

  #   ## Collect Base Zipcode
  #   if params[:zipcode]
  #     filter_criteria[:zipcode] = params[:zipcode]
  #   elsif current_user and current_user.zipcode
  #     filter_criteria[:zipcode] = current_user.zipcode
  #   else
  #     filter_criteria[:zipcode] = request.safe_location.postal_code
  #   end

  #   ## Collect Radius
  #   filter_criteria[:radius] = params[:radius].nil? ? 100 : params[:radius].to_i

  #   filter_criteria[:age] = get_checkbox_selections(:age, AGE_RANGES)

  #   filter_criteria[:gender] = get_checkbox_selections(:gender, GENDERS)

  #   filter_criteria[:mix] = get_dropdown_selection(:mix, MIXES)

  #   filter_criteria[:personality] = get_checkbox_selections(:personality, PERSONALITIES)

  #   filter_criteria[:like] = get_checkbox_selections(:like, LIKES)

  #   filter_criteria[:energy_level] = get_checkbox_selections(:energy_level, ENERGY_LEVELS)

  #   filter_criteria[:size] = get_checkbox_selections(:size, SIZES)

  #   Dog.filter_by filter_criteria

  # end

      # if params[:zipcode]
    #   @zipcode = params[:zipcode]
    # elsif current_user and current_user.zipcode
    #   @zipcode = current_user.zipcode
    # else
    #   @zipcode = request.safe_location.postal_code
    # end
    # @radius = params[:radius].nil? ? 100 : params[:radius]
    # @dogs = Dog.near(@zipcode, params[:radius].to_i, order: :distance)
    # filter_criteria = ['gender', 'personality', 'like', 'mix', 'size', 'energy_level', 'age']
    # filter_criteria.each {|criteria| filter_by(criteria)} 
    # @no_dogs = @dogs.empty?

      # def filter_by(model)
  #   unless model == "age" or model == "gender"
  #     instance_variable_set("@" + "all_#{model.pluralize}", model.classify.constantize.pluck('value'))
  #   end

  #   case model
  #   when "energy_level", "size"
  #       filter_single_attributes(model)
  #   when "like", "personality"
  #       filter_multiple_attributes(model)
  #   when "age"
  #       filter_by_age()
  #   when "mix"
  #       filter_by_mix()
  #   when "gender"
  #       filter_by_gender()
  #   end

  # end

  # def filter_by_age
  #   @age_ranges = ["0-2 years", "2-4 years", "5-8 years", "9+ years"]
  #   @age_pairs = [[0, 2], [2, 4], [5, 8], [9, 30]]
  #   @selected_ranges = get_checkbox_selections(:age)

  #   unless @selected_ranges.empty?
  #     valid_dogs = []
  #     @selected_ranges.each do |i|
  #       valid_dogs += @dogs.select {|dog| validate_dog_age?(dog, i.to_i)}
  #     end 
  #     @dogs = valid_dogs
  #   end
  # end

  # def validate_dog_age?(dog, i)
  #   dog.age >= @age_pairs[i][0] && dog.age <= @age_pairs[i][1]
  # end


  # def filter_single_attributes(model)

  #   selected_values = get_checkbox_selections(model)

  #   unless selected_values.empty?
  #       @dogs = @dogs.select {|dog| selected_values.include? dog.send(model)}
  #   end

  #   instance_variable_set("@" + "selected_#{model.pluralize}", selected_values)
  # end

  # def filter_multiple_attributes(arg)
  #   instance_variable_set("@" + "selected_#{arg.pluralize}", get_checkbox_selections(arg))

  #   method_name = "readable_#{arg.pluralize}"
  #   unless instance_variable_get("@" + "selected_#{arg.pluralize}").empty?
  #     @dogs = @dogs.select do |dog|
  #       (dog.public_send(method_name) - instance_variable_get("@" + "selected_#{arg.pluralize}")).length < dog.public_send(method_name).length  if dog.respond_to? method_name
  #     end
  #   end
  # end 

  # def filter_by_mix
  #   @all_mixes = ['All Mixes'] +  Mix.order(:value).pluck('value')
  #   @mix = get_dropdown_selection(:mix, 'All Mixes')

  #   unless @mix == 'All Mixes'
  #     @dogs = @dogs.select {|dog| dog.readable_mixes.include? @mix}
  #   end
  # end

  # def filter_by_gender
  #   @all_genders = ['Male', 'Female']
  #   @selected_genders = get_checkbox_selections('gender')
    
  #   unless @selected_genders.empty?
  #     @dogs = @dogs.select {|dog| @selected_genders.include? dog.gender}
  #   end
  # end
end


