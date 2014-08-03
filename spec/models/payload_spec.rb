require 'rails_helper'

describe Payload do

  subject { Payload.new }

  it { should validate_presence_of(:blob) }
  it { should validate_presence_of(:notificator) }
  it { should validate_presence_of(:repo_url) }
  it { should validate_presence_of(:request_host) }
  it { should have_and_belong_to_many(:notificators) }

  it 'validates if payload is allowed for request host' do
    notificator = FactoryGirl.build(:notificator, name: 'foo', notifying_host: '127.0.0.1')
    payload = subject.class.new(blob: '<foo>', request_host: '192.168.1.2', notificator: notificator)
    expect(payload).to have(1).errors_on(:request_host)
  end

  describe 'after_create' do
    it 'drops async job after creation' do
      expect_any_instance_of(Payload).to receive(:deploy!)
      FactoryGirl.create :payload
    end
  end

  describe '#deploy!' do
    it 'builds Deployer instance and call deploy! on it' do
      expect(Deployer).to receive(:new).with(payload: subject).and_return(double(:deploy! => true))
      subject.send(:deploy!)
    end
  end

end
