FactoryBot.define do
  factory :user do
    username {"mashael"}
    password {"password123"}
    password_confirmation {"password123"}
  end

  factory :employee do
    card_num {'41368'}
    first_name {'Mashael'}
    last_name {'Alemadi'}
    email {'malemadi@gmail.com'}
    phone {'50082008'}
    role {1}
    association :user
  end

end