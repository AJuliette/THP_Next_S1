# frozen_string_literal: true

1.upto(11) do
  Category.create!(
    name: Faker::Cat.breed,
    description: Faker::Cat.registry
  )
end
p "CATEGORIES créées"

1.upto(10) do
  Item.create!(
    original_price: Faker::Number.decimal(2),
    name: Faker::Cat.name
  )
end
p "ITEMS créés"

1.upto(10) do |i|
  Categorization.create!(
    category_id: i,
    item_id: i
  )
  Categorization.create!(
    category_id: i + 1,
    item_id: i
  )
end
p "CATEGORIZATIONS créées"
