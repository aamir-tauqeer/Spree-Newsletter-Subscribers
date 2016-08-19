module Spree
  module Admin
    class NewsletterSubscribersController < ResourceController
      def write_email

      end

      def send_email
        @newsletter = Spree::Newsletter.create!(params.require(:newsletter).permit!)
        Spree::NewsletterJob.perform_later(@newsletter.id)
        redirect_to admin_newsletter_subscribers_path
      end
    end
  end
end
