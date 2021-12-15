class Contact < ApplicationRecord
  enum contact_type: { request: 0, bug: 1, thoughts: 2, others: 3 }
  enum state: { not_started: 0, ongoing: 1, done: 2, withdraw: 3 }

  validates :message, presence: true, length: { in: 10..500 }
end
