require 'rails_helper'

describe '/api/payloads' do

  subject { api_payloads_url(:format => :json) }

  it 'determines the host of notificator' do
    post subject
    expect(assigns(:notifying_host)).to eq 'www.example.com'
  end

  it 'stores payload a serialized object' do
    post subject, payload: { megusta: 'foo' }
    expect(Payload.last.blob).to eq({'megusta' => 'foo' })
  end

end
