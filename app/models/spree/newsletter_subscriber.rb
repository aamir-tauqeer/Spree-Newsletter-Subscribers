module Spree
  class NewsletterSubscriber < ActiveRecord::Base
   
   attr_accessible :email, :first_name, :last_name
    
    validates :email,
              :presence => true,
              :uniqueness => true,
              :format => {:with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i}
    validates :first_name , :presence => true
    validates :last_name, :presence => true
  
  end
end
