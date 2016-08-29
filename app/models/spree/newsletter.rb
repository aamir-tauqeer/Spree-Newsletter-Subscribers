class Spree::Newsletter < ActiveRecord::Base
  def subscribers
    Spree::NewsletterSubscriber.where(confirmed: true, subscribed: true)
  end
end
