FactoryGirl.define do
  factory :book do
    name 'Война и Мир'
    description 'Роман-эпопея Льва Николаевича Толстого, описывающий русское общество в эпоху войн против Наполеона в 1805—1812 годах'
    author 'Лев Толстой'
    comment 'Хорошее произведение'
    rating 10
    user
  end
end
