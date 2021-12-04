class Bulk::HiddenVideosCollection < Bulk::Base
  attr_accessor :collection

  def initialize(attributes, user_id)
    return unless super(attributes)
    self.collection = attributes.map do |value|
      HiddenVideo.new(
        video_id: value['video_id'],
        user_id: user_id
      )
    end
  end
end