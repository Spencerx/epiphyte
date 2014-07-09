require 'rails_helper'

describe '/api/payloads' do

  subject { api_payloads_url(:format => :json) }

  it 'determines the host of notificator' do
    post subject
    expect(assigns(:notifying_host)).to eq 'www.example.com'
  end

end
