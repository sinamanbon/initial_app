FactoryGirl.define do
  factory :user do
    name     "Joseph Lee"
    email    "testing@testing.com"
    password "password"
    password_confirmation "password"
  end
end