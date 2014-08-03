require 'deployer'

class Payload < ActiveRecord::Base

  serialize :blob

  belongs_to :notificator
  has_one :project, through: :notificator
  validates :notificator, presence: true
  validates :repo_url, presence: true
  validates :blob, presence: true
  validates :request_host, presence: true

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
    Deployer.new(payload: self).deploy!
  end

end
