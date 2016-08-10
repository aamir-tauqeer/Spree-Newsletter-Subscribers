module Spree
  class NewsletterSubscribersController < BaseController

    def create
      @newsletter_subscriber = NewsletterSubscriber.new(product_import_params)

      respond_to do |format|
        if @newsletter_subscriber.save
          flash[:notice] = 'Your email address was successfully added as a subscriber.'
          format.html { redirect_to(root_url) }
        else
          flash[:error] = 'Unable to add your email address as a subscriber. Perhaps we already have it in our database.'
          format.html { redirect_to(root_url) }
        end
      end
    end

    private
      def product_import_params
        params.require(:newsletter_subscribers).permit!
      end

  end
end
