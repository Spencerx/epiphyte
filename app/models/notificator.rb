class Notificator < ActiveRecord::Base

  has_many :payloads
  validates :name, :presence => true
  validates :notifying_host, :presence => true

end
