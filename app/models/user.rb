class User < ApplicationRecord
    has_many :microposts, dependent: :destroy
    validates :name, :email, presence: true
    validates :name, length: {maximum: 30}
    validates :email, uniqueness: true

    has_secure_password
    #、has_secure_passwordを使ってパスワードをハッシュ化するためには、最先端のハッシュ関数であるbcryptライブラリが必要です。
    validates :password, presence: true, length: {minimum: 6}

    attr_accessor :remember_token

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    def User.new_token
        SecureRandom.urlsafe_base64
    end

    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
        remember_digest
    end

    def session_token
        remember_digest || remember
    end

    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    def forget
        update_attribute(:remember_digest, nil)
    end
end
