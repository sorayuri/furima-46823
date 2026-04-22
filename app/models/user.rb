class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    
  validates :nickname, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :birth_date, presence: true

   validates :email, presence: true, uniqueness: true,format: { with: URI::MailTo::EMAIL_REGEXP }

 KANA_REGEX = /\A[ァ-ヶー]+\z/.freeze

  with_options format: { with: KANA_REGEX, message: "は全角カタカナで入力してください" } do
    validates :last_name_kana
     validates :first_name_kana
   end

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze

  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'
end