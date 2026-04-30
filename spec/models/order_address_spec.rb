require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @order_address = FactoryBot.build(:order_address)
  end

  context '購入できるとき' do
    it '全ての値が正しければ保存できる' do
      expect(@order_address).to be_valid
    end
  end

  context '購入できないとき' do
    it 'userがなければ保存できない' do
      @order_address.user_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("User can't be blank")
    end

    it 'itemがなければ保存できない' do
      @order_address.item_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Item can't be blank")
    end

    it 'tokenが空では登録できない' do
      @order_address.token = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Token can't be blank")
    end

    it '郵便番号が空では保存できない' do
      @order_address.postal_code = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
    end

    it '郵便番号はハイフンなしでは保存できない' do
      @order_address.postal_code = '1234567'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Postal code is invalid')
    end

    it '郵便番号は全角文字列では保存できない' do
      @order_address.postal_code = '１２３-４５６７'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Postal code is invalid')
    end

    it '都道府県が未選択では保存できない' do
      @order_address.prefecture_id = 1
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Prefecture must be other than 1')
    end

    it '市区町村が空では保存できない' do
      @order_address.city = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("City can't be blank")
    end

    it '番地が空では保存できない' do
      @order_address.street_address = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Street address can't be blank")
    end

    it '電話番号が空では保存できない' do
      @order_address.phone_number = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
    end

    it '電話番号が10桁未満では保存できない' do
      @order_address.phone_number = '090123456'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number is invalid')
    end

    it '電話番号が12桁以上では保存できない' do
      @order_address.phone_number = '090123456789'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number is invalid')
    end

    it '電話番号が全角数値では保存できない' do
      @order_address.phone_number = '０９０１２３４５６７８'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number is invalid')
    end

    it '電話番号が文字列入りでは保存できない' do
      @order_address.phone_number = '090-1234-5678'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number is invalid')
    end
  end
end
