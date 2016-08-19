class Spree::Newsletter < ActiveRecord::Base
  def emails
    Spree::NewsletterSubscriber.where(confirmed: true, subscribed: true).map(&:email)
  end
end
