FactoryBot.define do
  factory :video do
    user
    sequence(:video_user) {|n| "user_#{n}"}
    sequence(:data_video_id) {|n| format("%019<number>d", number: n) }
    trait :latest_top do
			latest_top_flg  { true }
		end
    trait :cannot_play do
			cannot_play_flg  { true }
		end
  end
end