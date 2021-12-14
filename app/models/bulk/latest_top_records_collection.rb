class Bulk::LatestTopRecordsCollection < Bulk::Base
  attr_accessor :collection

  def initialize(attributes)
    return unless super(attributes)
    self.collection = attributes.map do |key, value|
      LatestTopRecord.new(
        video_id: key,
        user_id: Video.find(key).user_id,
        avg_score: value
      )
    end
  end
end