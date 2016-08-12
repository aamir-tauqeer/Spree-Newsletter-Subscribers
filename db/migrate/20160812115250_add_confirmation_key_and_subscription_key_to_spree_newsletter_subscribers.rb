class AddConfirmationKeyAndSubscriptionKeyToSpreeNewsletterSubscribers < ActiveRecord::Migration
  def change
    add_column :spree_newsletter_subscribers, :confirmation_key, :string
    add_index :spree_newsletter_subscribers, :confirmation_key, unique: true
    add_column :spree_newsletter_subscribers, :subscription_key, :string
    add_index :spree_newsletter_subscribers, :subscription_key, unique: true
  end
end
