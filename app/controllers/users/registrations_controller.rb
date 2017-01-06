class Users::RegistrationsController < Devise::RegistrationsController
# Extend Default Devise Gem Behavior so that
# Users Signing Up with the Pro Account (Plan ID 2)
# Save with a Special Stripe Subcription Function
# Else Devise Signs Up User as Usual.
  def create
    super do |resource|
      if params[:plan]
        resource.plan_id = params[:plan]
        if resource.plan_id == 2
          resource.save_with_subscription
        else
          resource.save
        end
      end
    end
  end
end
