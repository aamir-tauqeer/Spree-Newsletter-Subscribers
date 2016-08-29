module Spree
  class NewsletterJob < ActiveJob::Base
    queue_as :default

    def perform(newsletter_id, store_id)
      newsletter = Newsletter.find(newsletter_id)
      store = Store.find(store_id)
      Spree::NewsletterMailer.newsletter(newsletter, store).deliver
    end
  end
end
