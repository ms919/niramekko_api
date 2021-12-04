class Bulk::Base
  include ActiveModel::Model
  include ActiveModel::Callbacks
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks

  attr_accessor :collection

  def initialize(attributes)
    attributes.present?
  end

  def save
    ActiveRecord::Base.transaction do
      collection.each do |item|
        # バリデーションエラーがあれば例外発生×ロールバックさせる
        raise ActiveRecord::RecordInvalid unless item.save
      end
    end
    return true
    rescue => e
      p e
      return false
  end
end