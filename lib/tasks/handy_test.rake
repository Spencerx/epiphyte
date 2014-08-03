namespace :travis do

  desc 'Initiate Travis mocked request to localhost'
  task :request => :environment do
    repo_slug = 'opensuse/epiphyte'
    auth_header = Digest::SHA256.hexdigest(repo_slug + Rails.application.secrets.travis_token)
    file = File.read(Rails.root.join 'spec', 'fixtures', 'travis_webhook.json')
    request_json = JSON.parse(file, symbolize_keys: true)
    begin
      response = RestClient.post(
          'http://localhost:3000/api/projects/osem/notificators/travis/payloads.json',
          { :payload => request_json },
          :Accept => 'application/json',
          :Authorization => auth_header,
          :'Travis-Repo-Slug' => repo_slug
      )
    rescue => e
      response = e.response
    end
    ap JSON.parse(response)
  end

end
