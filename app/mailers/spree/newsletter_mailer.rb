module Spree
  class NewsletterMailer < BaseMailer
    def confirmation subscriber, current_store
      @subscriber = subscriber.respond_to?(:id) ? subscriber : NewsletterSubscriber.find(subscriber)
      @current_store = current_store.respond_to?(:id) ? current_store : Store.find(current_store)
      subject = 'Newsletter'
      mail(to: subscriber.email, from: from_address, subject: subject)
    end

    def newsletter(newsletter)
      @newsletter = newsletter.respond_to?(:id) ? newsletter : Spree::Newsletter.find(newsletter)
      subject = 'Newsletter'
      @newsletter.emails.each do |email|
        mail(to: email, from: from_address, subject: subject)
      end
    end
  end
end
