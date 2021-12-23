include TITLES

FactoryBot.define do
  factory :game_result do
    mode   {0}
    trait :gold do
      title { ID[GOLD] }
			score { SCORE_LEVELS[GOLD] }
		end
    trait :iron do
      title { ID[IRON] }
      score { SCORE_LEVELS[IRON] }
    end
    trait :soil do
      title { ID[SOIL] }
      score { SCORE_LEVELS[SOIL] }
    end
    trait :smile do
      title { ID[SMILE] }
      score { SCORE_LEVELS[SMILE] }
    end
    trait :laugh do
      title { ID[LAUGH] }
      score { SCORE_LEVELS[SMILE] - 0.1 }
    end
  end
end