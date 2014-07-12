class Deployer

  attr_accessor :payload

  def initialize(payload)

  end

  class << self

    def check_filesystem
      deploy_root = Rails.application.secrets.deploy['root']
      FileUtils.mkdir_p(deploy_root) unless Dir.exist?(deploy_root)
    end

  end

end
