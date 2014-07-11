require 'rails_helper'

describe '/api/notificators/:notificator_id/payloads' do

  context 'travis notificator' do

    let(:repo_slug) { 'opensuse/epiphyte' }

    let(:travis_headers) do
      {
        'Authorization' => Digest::SHA256.hexdigest(repo_slug + Rails.application.secrets.travis_token),
        'Travis-Repo-Slug' => 'opensuse/epiphyte'
      }
    end

    subject { api_notificator_payloads_url(:format => :json, :notificator_id => 'travis') }

    before do
      FactoryGirl.create :notificator, name: 'travis'
    end

    it 'finds a notificator by slug' do
      post subject, nil, travis_headers
      expect(assigns(:notificator).name).to eq 'travis'
    end

    it 'returns error if request host is not conformant with notificator' do
      host! 'nottravisallowed'
      post subject, nil, travis_headers
      expect(response.status).to eq 422
      expect(json_response[:errors][:request_host]).to eq ['is not allowed ip']
    end

    it 'validates authenticity by headers' do
      post subject, nil, { 'Authorization' => 'hack', 'Travis-Repo-Slug' => 'opensuse/epiphyte' }
      expect(response.status).to eq 401
      expect(json_response[:errors]).to eq ['Cannot confirm authenticity']
    end

  end

end
