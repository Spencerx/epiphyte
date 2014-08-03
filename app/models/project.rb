class Project < ActiveRecord::Base

  extend FriendlyId

  friendly_id :name, use: :slugged

  has_and_belongs_to_many :notificators
  has_many :payloads

  validates :name, presence: true

end
