class User < ApplicationRecord
    before_save { self.email = email.downcase }
    #has_many :articles, dependent: :destroy
    validates :username, presence: true, 
                        uniqueness: { case_sensitive:false }, 
                        length: { minimum: 3, maximum: 25 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, 
                        uniqueness: { case_sensitive:false }, 
                        length: { minimum: 3, maximun: 50 },
                        format: { with: VALID_EMAIL_REGEX}
    has_secure_password

    def self.search(search)
        if search
            user_name = User.find_by(username: search)
            if user_name
                self.where(username: user_name.username)
            else
                @users = User.all
            end
        else
            @users = User.all
        end
    end
    
    


end