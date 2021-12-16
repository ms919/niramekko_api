class Bulk::LaughedVideosCollection < Bulk::Base
  attr_accessor :collection

  def initialize(attributes, user_id)
    return unless super(attributes)
    self.collection = attributes.map do |value|
      LaughedVideo.new(
        video_id: value['video_id'],
        score_diff: value['score_diff'].ceil(1),
        user_id: user_id
      )
    end
  end
end