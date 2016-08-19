class CreateSpreeNewsletters < ActiveRecord::Migration
  def change
    create_table :spree_newsletters do |t|
      t.text :body
      t.timestamps null: false
    end
  end
end
