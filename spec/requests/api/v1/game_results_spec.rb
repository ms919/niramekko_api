require 'rails_helper'

describe '#create' do
  let(:params){ { game_result: { mode: :normal, score: score } } }
  let(:res){ response.body }
  context 'スコアが450以上の場合' do
    let(:score){ SCORE_LEVELS[GOLD] }
    it 'DBに登録されるゲーム結果のタイトルがGOLDであること' do
      expect { post '/api/v1/game_results', params: params, as: :json }.to change(GameResult, :count).by(+1)
      expect(res).to eq "gold"
    end
  end
  context 'スコアが400以上の場合' do
    let(:score){ SCORE_LEVELS[IRON] }
    it 'DBに登録されるゲーム結果のタイトルがIRONであること' do
      expect { post '/api/v1/game_results', params: params, as: :json }.to change(GameResult, :count).by(+1)
      expect(res).to eq "iron"
    end
  end
  context 'スコアが300以上の場合' do
    let(:score){ SCORE_LEVELS[SOIL] }
    it 'DBに登録されるゲーム結果のタイトルがSOILであること' do
      expect { post '/api/v1/game_results', params: params, as: :json }.to change(GameResult, :count).by(+1)
      expect(res).to eq "soil"
    end
  end
  context 'スコアが200以上の場合' do
    let(:score){ SCORE_LEVELS[SMILE] }
    it 'DBに登録されるゲーム結果のタイトルがSMILEであること' do
      expect { post '/api/v1/game_results', params: params, as: :json }.to change(GameResult, :count).by(+1)
      expect(res).to eq "smile"
    end
  end
  context 'スコアが200未満かつログイン中の場合' do
    let(:score){ SCORE_LEVELS[SMILE] - 0.1 }
    let(:user){ create(:user) }
    it 'DBに登録されるゲーム結果のタイトルがLAUGHであること' do
      login_as(user)
      expect { post '/api/v1/game_results', params: params, as: :json }.to change(GameResult, :count).by(+1)
      expect(res).to eq "laugh"
      expect(GameResult.last.user_id).to eq(user.id)
    end
  end
end
