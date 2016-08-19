module Spree
  class NewsletterMailer < BaseMailer
    def newsletter(newsletter)
      @newsletter = newsletter.respond_to?(:id) ? newsletter : Spree::Newsletter.find(newsletter)
      subject = 'Newsletter'
      @newsletter.emails.each do |email|
        mail(to: email, from: from_address, subject: subject)
      end
    end
  end
end
