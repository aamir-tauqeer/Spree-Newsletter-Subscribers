module Spree
  class NewsletterSubscribersController < BaseController
    def index
      redirect_to root_url
    end

    def create
      @newsletter_subscriber = NewsletterSubscriber.create(product_import_params)

      if @newsletter_subscriber.valid?
        NewsletterSubscriberJob.perform_later(@newsletter_subscriber.id, current_store.id)
        flash[:notice] = Spree.t(:successfully_subscribed)
        redirect_to(root_url)
      else
        if @newsletter_subscriber.errors.full_messages.to_sentence == "Email уже существует"
          flash[:error] = Spree.t(:already_subscribed)
        else
          flash[:error] = Spree.t(:wrong_email_input)
        end
        redirect_to(root_url)
      end
    end

    def confirm
      @newsletter_subscriber = NewsletterSubscriber.where(confirmation_key: params[:key]).first
      @newsletter_subscriber.update(confirmed: true) unless @newsletter_subscriber.confirmed
      @newsletter_subscriber.update(subscribed: true) unless @newsletter_subscriber.subscribed
      flash[:notice] = Spree.t(:successfully_confirmed)
      redirect_to(root_url)
    end

    def unsubscribe
      @newsletter_subscriber = NewsletterSubscriber.where(subscription_key: params[:key]).first
      @newsletter_subscriber.update(subscribed: false) if @newsletter_subscriber.subscribed
      flash[:notice] = Spree.t(:successfully_unsubscribed)
      redirect_to(root_url)
    end

    private
      def product_import_params
        params.require(:newsletter_subscribers).permit!
      end
  end
end
