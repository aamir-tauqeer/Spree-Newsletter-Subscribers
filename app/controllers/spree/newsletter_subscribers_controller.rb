module Spree
  class NewsletterSubscribersController < BaseController

    def create
      @newsletter_subscriber = NewsletterSubscriber.new(product_import_params)

      respond_to do |format|
        if @newsletter_subscriber.save
          flash[:notice] = Spree.t(:successfully_subscribed)
          format.html { redirect_to(root_url) }
        else
          if @newsletter_subscriber.errors.full_messages.to_sentence == "Email уже существует"
            flash[:error] = Spree.t(:already_subscribed)
          else
            flash[:error] = Spree.t(:wrong_email_input)
          end
          format.html { redirect_to(root_url) }
        end
      end
    end

    def confirm
      @newsletter_subscriber = NewsletterSubscriber.where(confirmation_key: params[:key]).first
      @newsletter_subscriber.update(confirmed: true) unless @newsletter_subscriber.confirmed
      @newsletter_subscriber.update(subscribed: true) unless @newsletter_subscriber.subscribed
    end

    def unsubscribe
      @newsletter_subscriber = NewsletterSubscriber.where(subscription_key: params[:key]).first
      @newsletter_subscriber.update(subscribed: false) if @newsletter_subscriber.subscribed
    end

    private
      def product_import_params
        params.require(:newsletter_subscribers).permit!
      end

  end
end
