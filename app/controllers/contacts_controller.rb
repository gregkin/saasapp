class ContactsController < ApplicationController
  
  # Get Request to /contact-us
  # Shows New Contact Form
  
  def new
    @contact = Contact.new
  end
  
  # Post Request /contacts
  def create
    # Mass assignment of Form Fields into the Contact Object
    @contact = Contact.new(contact_params)
    # Save the Contact Object to the Database
    if @contact.save
      # Store Form Fields via Parameters, into Variables 
      name = params[:contact][:name]
      email = params[:contact][:email]
      body = params[:contact][:comments]
      # Plug variables into Contact Mailer
      # Email Method and Send Email
      ContactMailer.contact_email(name, email, body).deliver
      # Store Success Message in Flash Hash
      # And Redirect to the New Action
      flash[:success] = "Message has been sent!"
      redirect_to new_contact_path
    else
      # If Contact Object doesn't save,
      # Store Errors in Flash Hash
      # And Redirect to the New Action.
      flash[:danger] = @contact.errors.full_messages.join(", ")
      redirect_to new_contact_path
    end
  end


  private
  # To Collect Data From Form, we Need to Use
  # Strong Parameters and Whitelist the Form Fields.
  def contact_params
    params.require(:contact).permit(:name, :email, :comments)
  end
end