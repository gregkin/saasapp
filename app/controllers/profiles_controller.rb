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
      redirect_to root_path
    else
      render action: :new
  end
end
  
  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :job_title, :phone_number, :contact_email, :description)
    end
end
  
