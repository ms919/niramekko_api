FactoryBot.define do
  factory :user_notification do
    user
    message  {'30.1'}
    format   {0}
    trait :read_flg do
      read_flg  { true }
    end
  end
end