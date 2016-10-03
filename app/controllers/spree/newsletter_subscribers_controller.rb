module Spree
  class NewsletterSubscribersController < BaseController

    def create
      @newsletter_subscriber = NewsletterSubscriber.create(product_import_params)

      if @newsletter_subscriber.valid?
        temp_pass = create_user(product_import_params[:email])

        NewsletterSubscriberJob.perform_later(@newsletter_subscriber.id, current_store.id, temp_pass)
        flash[:notice] = Spree.t(:successfully_subscribed)
        redirect_to(request.referrer || root_path)
      else
        if @newsletter_subscriber.errors.full_messages.to_sentence == "Email уже существует"
          flash[:error] = Spree.t(:already_subscribed)
        else
          flash[:error] = Spree.t(:wrong_email_input)
        end
        redirect_to(request.referrer || root_path)
      end
    end

    def edit
      @newsletter_subscriber = Spree::NewsletterSubscriber.find_by_id(params[:id])
      render :edit, layout: false
    end

    def update
      @newsletter_subscriber = Spree::NewsletterSubscriber.find_by_id(params[:id])
      @newsletter_subscriber.update(newsletter_subscriber_params)
      redirect_to(root_path)
    end

    def confirm
      @newsletter_subscriber = NewsletterSubscriber.where(confirmation_key: params[:key]).first
      @newsletter_subscriber.update(confirmed: true) unless @newsletter_subscriber.confirmed
      @newsletter_subscriber.update(subscribed: true) unless @newsletter_subscriber.subscribed
      flash[:notice] = Spree.t(:successfully_confirmed)
      redirect_to(root_path)
    end

    def unsubscribe
      @newsletter_subscriber = NewsletterSubscriber.where(subscription_key: params[:key]).first
      @newsletter_subscriber.update(subscribed: false) if @newsletter_subscriber.subscribed
      flash[:notice] = Spree.t(:successfully_unsubscribed)
      redirect_to(root_path)
    end

    private
      def product_import_params
        params.require(:newsletter_subscribers).permit!
      end

      def create_user(email)
        pass = generate_password
        user = Spree::User.new({
          email: email,
          password: pass,
          password_confirmation: pass,
          subscription: true
        })
        user.save!
        pass
      end

      def generate_password
        o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
        (0...10).map { o[rand(o.length)] }.join
      end

      def newsletter_subscriber_params
        params.require(:newsletter_subscriber).permit!
      end
  end
end
