FactoryBot.define do
  factory :user do
    sequence(:uid) {|n| format("%010<number>d", number: n) }
    provider       {"twitter"}
    sequence(:name) {|n|"user_#{n}"}
    trait :admin do
			role { :admin }
		end
  end
end