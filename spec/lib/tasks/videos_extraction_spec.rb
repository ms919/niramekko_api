require 'rails_helper'
require 'rake_helper'

describe 'videos_extraction:update_latest_top' do
  subject(:task) { Rake.application['videos_extraction:update_latest_top'] }

  context '昨日一日のlaughed_videosが2つの場合' do
    it 'LatestTopRecordが追加されないこと' do
      create_list(:laughed_video, 2)
      task.invoke
      expect(LatestTopRecord.count).to eq(0)
      expect(Video.where(latest_top_flg: true).count).to eq(0)
    end
  end
  context '昨日一日のlaughed_videosが3つの場合' do
    it 'Videoのlatest_top_flgが更新され、LatestTopRecordが追加されること' do
      create_list(:laughed_video, 3)
      expect { task.invoke }.to change(LatestTopRecord, :count).by(+3)
      expect(Video.where(id: LatestTopRecord.pluck(:video_id)).pluck(:latest_top_flg).uniq!).to eq([true])
    end
  end
end