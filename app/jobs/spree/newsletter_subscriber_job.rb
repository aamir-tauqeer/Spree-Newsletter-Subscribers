module Spree
  class NewsletterSubscriberJob < ActiveJob::Base
    queue_as :default

    def perform(subscriber_id, store_id)
      subscriber = NewsletterSubscriber.find(subscriber_id)
      store = Store.find(store_id)
      NewsletterMailer.confirmation(subscriber, store).deliver
    end
  end
end
