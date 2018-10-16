class Spree::Newsletter < ActiveRecord::Base
  def emails
    Spree::NewsletterSubscriber.all.map(&:email)
  end
end
