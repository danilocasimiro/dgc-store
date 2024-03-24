# frozen_string_literal: true

require 'faker'

company = Company.create!(
  owner_id: 1
)
['Frutas e Vegetais', 'Laticínios', 'Carnes e Aves', 'Pães e Grãos'].each do |product_type_name|
  ProductType.create!(
    name: product_type_name,
    company: company
  )
end

['Maças', 'Bananas', 'Tomates', 'Alface', 'Cenouras'].each do |product_name|
  Product.create!(
    name: product_name,
    product_type: ProductType.find(1),
    price: Faker::Commerce.price,
    stock: Faker::Number.unique.number(digits: 4)
  )
end

['Leite', 'Queijo', 'Iogurte', 'Manteiga', 'Creme de leite'].each do |product_name|
  Product.create!(
    name: product_name,
    product_type: ProductType.find(2),
    price: Faker::Commerce.price,
    stock: Faker::Number.unique.number(digits: 4)
  )
end

['Carne bovina Filé mignon', 'Peito de frango', 'Bistequinha de porco', 'Filé de salmão', 'Linguiça toscana'].each do |product_name|
  Product.create!(
    name: product_name,
    product_type: ProductType.find(3),
    price: Faker::Commerce.price,
    stock: Faker::Number.unique.number(digits: 4)
  )
end

['Pão branco', 'Pão integral', 'Arroz', 'Macarrão', 'Cereal'].each do |product_name|
  Product.create!(
    name: product_name,
    product_type: ProductType.find(4),
    price: Faker::Commerce.price,
    stock: Faker::Number.unique.number(digits: 4)
  )
end
