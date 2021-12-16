class Bulk::UserNotificationsCollection < Bulk::Base
  attr_accessor :collection

  def initialize(attributes, format)
    return unless super(attributes)
    self.collection = attributes.map do |value|
      UserNotification.new(
        user_id: value.user_id,
        format: format,
        message: value.avg_score.ceil(1)
      )
    end
  end
end