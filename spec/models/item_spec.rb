require 'rails_helper'

RSpec.describe Item, type: :model do
  before do 
    @item = FactoryBot.build(:item)
  end

it "全ての値が正しければ保存できる" do
  expect(@item).to be_valid
 end

  it "商品名が空では保存できない" do
     @item.name = ""
     @item.valid?
     expect(@item.errors.full_messages).to include("Name can't be blank")
  end

 it "商品の説明が空では保存できない" do
     @item.description = ""
     @item.valid?
     expect(@item.errors.full_messages).to include("Description can't be blank")
  end

  it "商品画像がない場合は保存できない" do
     @item.image = nil
     @item.valid?
     expect(@item.errors.full_messages).to include("Image can't be blank")
  end

  it "カテゴリーが未選択では保存できない" do
    @item.category_id = 1
    @item.valid?
    expect(@item.errors.full_messages).to include("Category can't be blank")
  end

  it "商品の状態が未選択では保存できない" do
    @item.condition_id = 1
    @item.valid?
    expect(@item.errors.full_messages).to include("Condition can't be blank")
  end

  it "配送料の負担が未選択では保存できない" do
    @item.shipping_fee_id = 1
    @item.valid?
    expect(@item.errors.full_messages).to include("Shipping fee can't be blank")
  end

   it "発送元の地域が未選択では保存できない" do
    @item.prefecture_id = 1
    @item.valid?
    expect(@item.errors.full_messages).to include("Prefecture can't be blank")
  end

  it "発送までの日数が未選択では保存できない" do
    @item.shipping_day_id = 1
    @item.valid?
    expect(@item.errors.full_messages).to include("Shipping day can't be blank")
  end

  it "価格が空では保存できない" do
    @item.price = nil
    @item.valid?
    expect(@item.errors.full_messages).to include("Price can't be blank")
  end
  
  it "価格が300未満では保存できない" do
    @item.price = 299
    @item.valid?
    expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
  end

  it "価格が9999999を超える場合は保存できない" do
    @item.price = 10000000
    @item.valid?
    expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
  end

   it "価格が全角数字では保存できない" do
     @item.price = "３０００"
     @item.valid?
      expect(@item.errors.full_messages).to include("Price is not a number")
   end
  end