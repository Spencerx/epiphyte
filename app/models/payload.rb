require 'deployer'

class Payload < ActiveRecord::Base

  serialize :blob

  belongs_to :notificator
  belongs_to :project
  validates :notificator, presence: true
  validates :repo_url, presence: true
  validates :blob, presence: true
  validates :request_host, presence: true

  validate :allowed_host, :supported_notificator

  before_validation :extract_repo_url
  after_create :deploy!

  private

  def allowed_host
    if notificator && request_host != notificator.notifying_host
      errors.add(:request_host, "#{request_host} is not allowed ip")
    end
  end

  def extract_repo_url
    self.repo_url = blob['repository']['url'] if blob && blob['repository']
  end

  def supported_notificator
    unless project && project.notificators.include?(notificator)
      errors.add(:project, 'requested project does not supports requested notificator')
    end
  end

  def deploy!
    #Rails.queue[:deployments].push(Deployer.new(payload: self).deploy!)
  end

end
