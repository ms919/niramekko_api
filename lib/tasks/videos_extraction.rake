namespace :videos_extraction do
	desc 'Update the latest laughed at video.'
	task update_latest_top_flg: :environment do
		if LaughedVideo.latest_laughed_videos.length >= 3
			Video.where(latest_top_flg: true).update(latest_top_flg: false)
			Video.latest_top_videos.update(latest_top_flg: true)
		end
	end
end
