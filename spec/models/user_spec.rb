require 'rails_helper'

RSpec.describe User, type: :model do
   before do
    @user = FactoryBot.build(:user)
end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "全ての項目が正しく入力されていれば登録できる" do
        expect(@user).to be_valid
      end
    end

   context '新規登録できない場合' do
     it "ニックネームが空では登録できない" do
      @user.nickname = ''
       @user.valid?
       expect(@user.errors.full_messages).to include("Nickname can't be blank")
     end

      it "メールアドレスが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

       it "メールアドレスが一意でないと登録できない" do
         @user.save!
         another_user = FactoryBot.build(:user, email: @user.email)
         another_user.valid?
         expect(another_user.errors.full_messages).to include("Email has already been taken")
       end

       it "メールアドレスは@を含まないと登録できない" do
        @user.email = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
       end


        it "パスワードが空では登録できない" do
          @user.password = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Password can't be blank")
        end

        it "パスワードは6文字以上でないと登録できない" do
          @user.password = 'a1b2'
          @user.password_confirmation = 'a1b2'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
          end

         it "パスワードは英字のみでは登録できない" do
          @user.password = 'aaaaaa'
          @user.password_confirmation = 'aaaaaa'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password must include both letters and numbers")
        end

        it "パスワードは数字のみでは登録できない" do
          @user.password = '123456'
          @user.password_confirmation = '123456'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password must include both letters and numbers")
        end
        
        it "パスワードと確認用パスワードが一致しないと登録できない" do
          @user.password = 'abc123'
          @user.password_confirmation = 'abc124'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end


         it "名字が空では登録できない" do
          @user.last_name = ''
          @user.valid?
         expect(@user.errors.full_messages).to include("Last name can't be blank")
         end

          it "名前が空では登録できない" do
             @user.first_name = ''
             @user.valid?
             expect(@user.errors.full_messages).to include("First name can't be blank")
          end

          it "名字カナが空では登録できない" do
            @user.last_name_kana = ''
            @user.valid?
            expect(@user.errors.full_messages).to include("Last name kana can't be blank")
          end

          it "名前カナが空では登録できない" do
            @user.first_name_kana = ''
            @user.valid?
            expect(@user.errors.full_messages).to include("First name kana can't be blank")
          end

          it "名字カナは全角カタカナでないと登録できない" do
            @user.last_name_kana = 'やまだ'
            @user.valid?
            expect(@user.errors.full_messages).to include("Last name kana Input full-width characters")
          end

          it "名前カナは全角カタカナでないと登録できない" do
            @user.first_name_kana = 'たろう'
            @user.valid?
            expect(@user.errors.full_messages).to include("First name kana Input full-width characters")
          end


           it "生年月日が空では登録できない" do
            @user.birth_date = nil
            @user.valid?
            expect(@user.errors.full_messages).to include("Birth date can't be blank")
          end
        end
      end
    end