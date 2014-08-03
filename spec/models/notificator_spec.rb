require 'rails_helper'

describe Notificator do

  it { should have_many(:payloads) }
  it { should have_and_belong_to_many(:projects) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:notifying_host) }

end
