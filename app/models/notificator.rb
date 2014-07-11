class Notificator < ActiveRecord::Base

  extend FriendlyId

  has_many :payloads
  validates :name, presence: true
  validates :notifying_host, presence: true, uniqueness: true
  friendly_id :name, use: :slugged

end
