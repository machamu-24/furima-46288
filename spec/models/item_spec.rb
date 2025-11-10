# spec/models/item_spec.rb
require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  context '出品できる時' do
    it '全ての値が正しければ出品できる' do
      expect(@item).to be_valid
    end
  end

  context '出品できない時' do
    it '画像が必須' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end

    it '商品名が必須' do
      @item.name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end

    it '説明が必須' do
      @item.description = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Description can't be blank")
    end

    it 'カテゴリーが---(1)だと不可' do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Category を選択してください')
    end

    it '状態が---(1)だと不可' do
      @item.condition_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Condition を選択してください')
    end

    it '配送料負担が---(1)だと不可' do
      @item.shipping_fee_status_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Shipping fee status を選択してください')
    end

    it '都道府県が---(1)だと不可' do
      @item.prefecture_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Prefecture を選択してください')
    end

    it '発送までの日数が---(1)だと不可' do
      @item.shipping_day_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Shipping day を選択してください')
    end

    it '価格が必須' do
      @item.price = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end

    it '価格が300未満は不可' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
    end

    it '価格が9,999,999より大きいと不可' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
    end

    it '価格が半角数字以外だと不可（全角）' do
      @item.price = '３００'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price は半角数字で入力してください')
    end

    it '価格が半角英数混合は不可（数字のみ許可）' do
      @item.price = '1000yen'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price は半角数字で入力してください')
    end
  end
end
