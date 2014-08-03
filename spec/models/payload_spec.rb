require 'rails_helper'

describe Payload do

  subject { Payload.new }

  it { should validate_presence_of(:blob) }
  it { should validate_presence_of(:notificator) }
  it { should validate_presence_of(:repo_url) }
  it { should validate_presence_of(:request_host) }
  it { should belong_to(:notificator) }

  it 'validates if payload is allowed for request host' do
    notificator = FactoryGirl.build(:notificator, name: 'foo', notifying_host: '127.0.0.1')
    payload = subject.class.new(blob: '<foo>', request_host: '192.168.1.2', notificator: notificator)
    expect(payload).to have(1).errors_on(:request_host)
  end

  it 'validates if project supports provided notificator' do
    expect(subject).to have(1).errors_on(:project)
    expect(subject.errors_on(:project)).to include('requested project does not supports requested notificator')
  end

  describe 'after_create' do
    xit 'drops async job after creation' do
      expect_any_instance_of(Payload).to receive(:deploy!)
      FactoryGirl.create :payload
    end
  end

  describe '#deploy!' do
    xit 'builds Deployer instance and call deploy! on it' do
      expect(Deployer).to receive(:new).with(payload: subject).and_return(double(:deploy! => true))
      subject.send(:deploy!)
    end
  end

end
