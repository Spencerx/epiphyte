require 'rails_helper'

describe '/api/projects/:project_id/notificators/:notificator_id/payloads' do

  context 'travis notificator' do

    let(:repo_slug) { 'opensuse/epiphyte' }
    let(:project) { FactoryGirl.create(:project, name: 'myProject') }
    let(:notificator) { FactoryGirl.create :notificator, name: 'travis' }

    let(:travis_headers) do
      {
        'Authorization' => Digest::SHA256.hexdigest(repo_slug + Rails.application.secrets.travis_token),
        'Travis-Repo-Slug' => 'opensuse/epiphyte'
      }
    end

    let(:payload) { JSON.load(Rails.root.join('spec', 'fixtures', 'travis_webhook.json')) }

    subject { api_project_notificator_payloads_url(format: :json, notificator_id: 'travis', project_id: 'myProject') }

    before do
      project.notificators << notificator
    end

    it 'finds a notificator by slug' do
      post subject, nil, travis_headers
      expect(assigns(:notificator)).to_not be nil
    end

    it 'finds a project by slug' do
      post subject, nil, travis_headers
      expect(assigns(:project)).to_not be nil
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

    it 'saves properly formed payload' do
      post subject, { payload: payload }, travis_headers
      expect(response.status).to eq 201
    end

  end

end
