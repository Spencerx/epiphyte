class Payload < ActiveRecord::Base

  belongs_to :notificator
  validates :blob, :presence => true
  serialize :blob

end
