class CreateSpreeNewsletterSubscribers < ActiveRecord::Migration
  def up
    create_table :spree_newsletter_subscribers do |t|
      t.string :first_name, :limit => 50
      t.string :last_name, :limit => 50
      t.string :email, :limit => 50
      t.timestamps
    end
  end

  def down
    drop_table :spree_newsletter_subscribers
  end
end
