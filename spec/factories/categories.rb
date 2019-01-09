# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { Faker::Cat.breed }
    description { Faker::Cat.registry }
  end
end
