module Spree
  class NewsletterJob < ActiveJob::Base
    queue_as :default

    def perform(newsletter_id)
      Spree::NewsletterMailer.newsletter(newsletter_id).deliver
    end
  end
end
