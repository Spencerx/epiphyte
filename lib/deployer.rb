require 'open3'

class Deployer

  WORKSPACE_ROOT = Rails.application.secrets.deploy['root']

  attr_accessor :payload

  def initialize(payload: nil)
    @payload = payload
  end

  def deploy!
    check_deploy_root WORKSPACE_ROOT
  end

  def check_deploy_root
    deploy_root =
    FileUtils.mkdir_p(deploy_root) unless Dir.exist?(deploy_root)
  end

end
