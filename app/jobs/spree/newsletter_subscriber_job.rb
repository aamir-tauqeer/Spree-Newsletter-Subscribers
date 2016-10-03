module Spree
  class NewsletterSubscriberJob < ActiveJob::Base
    queue_as :default

    def perform(subscriber_id, store_id, temp_pass)
      subscriber = NewsletterSubscriber.find(subscriber_id)
      store = Store.find(store_id)
      NewsletterMailer.confirmation(subscriber, store, temp_pass).deliver
    end
  end
end
