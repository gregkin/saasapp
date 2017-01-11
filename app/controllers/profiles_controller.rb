class ProfilesController < ApplicationController

# Get to /users/:user_id/profile/new
  def new
   # Render a blank profile details form
   @profile = Profile.new
  end

# POST to /users/:user_id/profile  
def create
   # Ensure We Have the Current User Who is Filling OUt the Form. 
    @user = User.find( params[:user_id] )
    # Create Profile Linked to This specific User. 
    @profile = @user.build_profile( profile_params)
  if @profile.save
      flash[:success] = "Profile Updated!"
      redirect_to user_path(id: params[:user_id] )
    else
      render action: :new
  end
end

  # Get / to /users/:user_id/profile/edit
  def edit
    @user = User.find( params[:user_id] )
    @profile = @user.profile
  end
  
  # PATCH / to /users/:user_id/profile
  def update
    # Retrieve the User fron the Database
    @user = User.find( params[:user_id] )
    # Retrieve that Users Profile
    @profile = @user.profile
    # Mass Assign Edited Profile Attributes and Save (Update)
    if @profile.update.attributes(profile_params)
      flash[:success] = "Profile Updated!"
      # Redirect user to thier Profile Page
    redirect_to user_path( params[:user_id] )
  else
    render action: :edit
    end
    
  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
    end
  end
end  
