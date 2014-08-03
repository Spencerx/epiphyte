require 'rails_helper'

describe Deployer do

  subject { described_class }

  it 'initialized with payload' do
    expect(subject.new(payload: :foo).payload).to eq :foo
  end

  describe '#deploy!' do

    subject { described_class.new }

    it 'checks if deploy_root is created' do
      expect(subject).to receive(:check_deploy_root)
      subject.deploy!
    end

  end

  describe '#get_repo' do

    it 'downloads a repo from github' do
      expect(Open3).to receive(:capture2e).with("git clone --depth 1 --branch master #{payload.repo_url} #{}")
    end

  end


end
