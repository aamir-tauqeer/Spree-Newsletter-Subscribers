module Spree
  class NewsletterSubscriber < ActiveRecord::Base

    validates :email,
              :presence => true,
              :uniqueness => true,
              :format => {:with => /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i}
    # validates :first_name , :presence => true
    # validates :last_name, :presence => true

  end
end
