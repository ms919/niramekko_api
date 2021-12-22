include TITLES

FactoryBot.define do
  factory :game_result do
    mode   {0}
    trait :gold do
			score { SCORE_LEVELS[GOLD] }
		end
    trait :iron do
      score { SCORE_LEVELS[IRON] }
    end
    trait :soil do
      score { SCORE_LEVELS[SOIL] }
    end
    trait :smile do
      score { SCORE_LEVELS[SMILE] }
    end
    trait :laugh do
      score { SCORE_LEVELS[SMILE] - 0.1 }
    end
  end
end