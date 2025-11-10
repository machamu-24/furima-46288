# app/models/prefecture.rb
class Prefecture < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    # 2..48 に47都道府県を並べる（教材同梱ActiveHash等があればそれを利用）
    # 例：
    { id: 2, name: '北海道' }, { id: 3, name: '青森県' }, # ... 省略 ...
    { id: 48, name: '沖縄県' }
  ]
  include ActiveHash::Associations
  has_many :items
end
