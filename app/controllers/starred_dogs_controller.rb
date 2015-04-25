class StarredDogsController < ApplicationController
  before_filter :set_dog
  
  def create
    if Star.create(dog: @dog, user: current_user)
      redirect_to :back
    end
  end
  
  def destroy
    Star.where(dog_id: @dog.id, user_id: current_user.id).first.destroy
    redirect_to :back
  end
  
  private
  
  def set_dog
    @dog = Dog.find(params[:dog_id])
  end
end