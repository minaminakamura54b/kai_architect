class User < ApplicationRecord
    validates :name, :email, presence: true
    validates :name, length: {maximum: 30}
    validates :email, uniqueness: true

    has_secure_password
    #、has_secure_passwordを使ってパスワードをハッシュ化するためには、最先端のハッシュ関数であるbcryptライブラリが必要です。
    validates :password, presence: true, length: {minimum: 6}
end
