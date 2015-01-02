class ProfilesController < ApplicationController
  before_filter :signed_in_user
  
  def create
    @profile = current_user.profiles.build(profile_params)
    
    if @profile.save
      flash[:success] = "Profile created!"
      redirect_to current_user
    else
      render 'new'
    end
  end
  
  def update
    @profile = current_user.profiles.find_by_id(params[:id])    
    @profile.update_attributes(profile_params)
    
    if @profile.save
      flash[:success] = "profile updated!"
      redirect_to @profile
    else
      #flash[:]
      redirect_to 'edit'
    end
  end

  def edit
    @profile = current_user.profiles.first
  end

  def show
    @profile = current_user.profiles.first
  end
  
  def new
    @profile = current_user.profiles.build if signed_in?
  end
  
  private
  
    def profile_params
      params.require(:profile).permit(:dateOfBirth, :dateOfBirthRange, :country, :city, 
              :occupation, :college, :educationDegree, :domainOfStudy, :introduction)
    end
    
    
end
