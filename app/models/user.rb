class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
belongs_to :plan
  
  attr_accessor :stripe_card_token
# If Pro User Passes validations (email, password, etc }
# Then Call Stripe and tell Stripe to Setup a Subscription
# Upon charging the Customer's Card.
# Stripe responds Back with Customer data
# Store Customer ID as the Customer Token and Save the User.
  def save_with_subscription
    if valid?
      customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token)
      self.stripe_customer_token = customer.id
      save!
    end
  end
end
