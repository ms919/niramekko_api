class Bulk::HiddenVideosCollection < Bulk::Base
  attr_accessor :collection

  def initialize(attributes, user_id)
    if attributes.present?
      self.collection = attributes.map do |value|
        HiddenVideo.new(
          video_id: value['video_id'],
          user_id: user_id
        )
      end
    end
  end

  def save
    is_success = true
    ActiveRecord::Base.transaction do
      collection.each do |result|
        # バリデーションを全てかけるためsaveを使用
        is_success = false unless result.save
      end
      # バリデーションエラーがあれば例外発生×ロールバックさせる
      raise ActiveRecord::RecordInvalid unless is_success
    end
    rescue => e
      p e
    ensure
      return is_success
  end
end