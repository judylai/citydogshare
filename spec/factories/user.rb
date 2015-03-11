FactoryGirl.define do
  factory :user do
    uid 12345
    name "Bruce Wayne"
    first_name "Bruce"
    last_name "Wayne"
    oauth_token "ABCDEF..."
    oauth_expires_at 1321747205
  end
end
