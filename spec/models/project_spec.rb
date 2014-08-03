require 'rails_helper'

describe Project do

  it { should have_and_belong_to_many(:notificators) }
  it { should have_many(:payloads).through(:notificators) }

end
