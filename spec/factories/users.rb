FactoryBot.define do
  factory :user do
    sequence(:uid)  {|n| format("%010<number>d", number: n) }
    provider        {"twitter"}
    sequence(:name) {|n|"user_#{n}"}
    trait :admin do
			role { :admin }
		end
    factory :user_without_revenge do
      laughed_videos     { [association(:laughed_video), association(:laughed_video)] }
    end
    factory :user_with_revenge do
      laughed_videos     { [association(:laughed_video), association(:laughed_video), association(:laughed_video)] }
      game_results       { [association(:game_result, :soil)] }
      after(:create) do |user|
        create(:user_notification, user: user)
        create(:user_notification, user: user, read_flg: true)
      end
    end
  end
end