class AddConfirmedAndSubscribedToSpreeNewsletterSubscribers < ActiveRecord::Migration
  def change
    add_column :spree_newsletter_subscribers, :confirmed, :boolean, default: false
    add_column :spree_newsletter_subscribers, :subscribed, :boolean, default: true
  end
end
