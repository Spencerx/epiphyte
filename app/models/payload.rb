require 'deployer'

class Payload < ActiveRecord::Base

  belongs_to :notificator
  validates :notificator, presence: true
  validates :repo_url, presence: true
  validates :blob, presence: true
  validates :request_host, presence: true
  serialize :blob
  validate :allowed_host
  before_validation :extract_repo_url
  after_create :deploy!

  private

  def allowed_host
    if notificator && request_host != notificator.notifying_host
      errors.add(:request_host, 'is not allowed ip')
    end
  end

  def extract_repo_url
    self.repo_url = blob['repository']['url'] if blob && blob['repository']
  end

  def deploy!
    Deployer.check_filesystem
  end

end
