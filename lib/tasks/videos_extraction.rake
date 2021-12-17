namespace :videos_extraction do
	desc 'Update the latest laughed at video.'
	task update_latest_top: :environment do
		if LaughedVideo.select(:video_id).latest_laughed_videos.length >= 3
			# latest_top_flg更新
			Video.where(latest_top_flg: true).update(latest_top_flg: false)
			Video.latest_top_videos.update(latest_top_flg: true)
			# latest_top_records更新
			avg_score_arr = LaughedVideo.latest_laughed_videos.score_diff_order.average(:score_diff)
			latest_top_records = Bulk::LatestTopRecordsCollection.new(avg_score_arr)
			latest_top_records.save
			# user_id=nilがあれば削除
			LatestTopRecord.destroy_by(user_id: nil)
		end
	end
end
