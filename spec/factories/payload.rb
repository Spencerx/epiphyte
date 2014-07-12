FactoryGirl.define do
  factory :payload do
    repo_url 'MyString'
    request_host 'www.example.com'
    blob { JSON.load(Rails.root.join('spec', 'fixtures', 'travis_webhook.json')) }
    association :notificator
  end
end
