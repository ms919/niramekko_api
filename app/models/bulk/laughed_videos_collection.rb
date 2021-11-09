class Bulk::LaughedVideosCollection < Bulk::Base
  attr_accessor :collection

  def initialize(attributes)
    # byebug
    if attributes.present?
      self.collection = attributes.map do |value|
        LaughedVideo.new(
          video_id: value['video_id'],
          score_diff: value['score_diff']
        )
      end
    end
  end

  def save
    # byebug
    is_success = true
    ActiveRecord::Base.transaction do
      collection.each do |result|
        # バリデーションを全てかけたいからsave!ではなくsaveを使用
        is_success = false unless result.save
      end
      # バリデーションエラーがあった時は例外を発生させてロールバックさせる
      raise ActiveRecord::RecordInvalid unless is_success
    end
    rescue => e
      p e
    ensure
      return is_success
  end
end