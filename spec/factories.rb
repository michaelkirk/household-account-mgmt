FactoryGirl.define do
  factory :member do
    first_name "Janine"
    last_name "Member"
  end

  factory :transaction do
    credit true
    association :household
    sequence(:amount) { |n| "#{n}" }
    sequence(:message) { |n|  "Message #{n}" }
  end

  factory :household do
  end

  factory :purchase, :class => Transaction do
    credit false
    amount 10
    association :household
  end

  factory :investment, :class => Transaction do
    credit true
    amount 10
    association :household
  end
end

