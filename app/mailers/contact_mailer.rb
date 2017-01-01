class ContactMailer < ActionMailer::Base
  default to: 'mrgregking@msn.com'
  
  def contact_email(name, email, body)
    @name = name
    @email = email
    @body = body
    mail(from: email, subject: 'Contact Form Message')
  end
end
