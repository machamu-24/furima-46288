class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  # ActiveHash
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee_status
  belongs_to :shipping_day
  belongs_to :prefecture

  # バリデーション
  with_options presence: true do
    validates :image
    validates :name
    validates :description
    validates :price
    validates :category_id
    validates :condition_id
    validates :shipping_fee_status_id
    validates :shipping_day_id
    validates :prefecture_id
  end

  with_options numericality: { other_than: 1, message: 'を選択してください' } do
    validates :category_id
    validates :condition_id
    validates :shipping_fee_status_id
    validates :shipping_day_id
    validates :prefecture_id
  end

  validates :price,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 300,
              less_than_or_equal_to: 9_999_999
            },
            format: { with: /\A[0-9]+\z/, message: '半角数字で入力してください' }
end
