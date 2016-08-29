module Spree
  class NewsletterMailer < BaseMailer
    def confirmation subscriber, current_store
      @subscriber = subscriber.respond_to?(:id) ? subscriber : NewsletterSubscriber.find(subscriber)
      @current_store = current_store.respond_to?(:id) ? current_store : Store.find(current_store)
      subject = 'Newsletter'
      mail(to: subscriber.email, from: from_address, subject: subject)
    end

    def newsletter(newsletter, current_store)
      @newsletter = newsletter.respond_to?(:id) ? newsletter : Newsletter.find(newsletter)
      @current_store = current_store.respond_to?(:id) ? current_store : Store.find(current_store)
      subject = 'Newsletter'
      @newsletter.subscribers.each do |subscriber|
        @subscriber = subscriber
        mail(to: subscriber.email, from: from_address, subject: subject)
      end
    end
  end
end
