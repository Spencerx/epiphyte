class Payload < ActiveRecord::Base

  belongs_to :notificator
  validates :notificator, presence: true
  validates :blob, presence: true
  serialize :blob
  validate :allowed_host

  private

  def allowed_host
    if notificator && request_host != notificator.notifying_host
      errors.add(:request_host, 'is not allowed ip')
    end
  end

end
