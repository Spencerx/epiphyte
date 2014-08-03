class Notificator < ActiveRecord::Base

  extend FriendlyId

  has_many :payloads
  has_and_belongs_to_many :projects

  validates :name, presence: true
  validates :notifying_host, presence: true, uniqueness: true

  friendly_id :name, use: :slugged

end
