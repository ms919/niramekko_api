require 'rails_helper'
include TITLES

describe '#create' do
  let(:params){ { game_result: { mode: :normal, score: score } } }
  let(:res){ JSON.parse(response.body) }
  context 'スコアが450以上の場合' do
    let(:score){ SCORE_LEVELS[GOLD] }
    it 'DBに登録されるゲーム結果のタイトルがGOLDであること' do
      expect { post '/api/v1/game_results', params: params, as: :json }.to change(GameResult, :count).by(+1)
      expect(res).to eq ID[GOLD]
    end
  end
  context 'スコアが400以上の場合' do
    let(:score){ SCORE_LEVELS[IRON] }
    it 'DBに登録されるゲーム結果のタイトルがIRONであること' do
      expect { post '/api/v1/game_results', params: params, as: :json }.to change(GameResult, :count).by(+1)
      expect(res).to eq ID[IRON]
    end
  end
  context 'スコアが300以上の場合' do
    let(:score){ SCORE_LEVELS[SOIL] }
    it 'DBに登録されるゲーム結果のタイトルがSOILであること' do
      expect { post '/api/v1/game_results', params: params, as: :json }.to change(GameResult, :count).by(+1)
      expect(res).to eq ID[SOIL]
    end
  end
  context 'スコアが200以上の場合' do
    let(:score){ SCORE_LEVELS[SMILE] }
    it 'DBに登録されるゲーム結果のタイトルがSMILEであること' do
      expect { post '/api/v1/game_results', params: params, as: :json }.to change(GameResult, :count).by(+1)
      expect(res).to eq ID[SMILE]
    end
  end
  context 'スコアが200未満の場合' do
    let(:score){ SCORE_LEVELS[SMILE] - 0.1 }
    it 'DBに登録されるゲーム結果のタイトルがLAUGHであること' do
      expect { post '/api/v1/game_results', params: params, as: :json }.to change(GameResult, :count).by(+1)
      expect(res).to eq ID[LAUGH]
    end
  end
end
