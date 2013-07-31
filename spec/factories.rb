FactoryGirl.define do
  factory :user do
    #sequence of name & email for unique user name/email
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
  end
end