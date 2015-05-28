FactoryGirl.define do
  factory :login do
    username "test"
    password "testpasswordhorseandroid"
  end
 
  factory :user do
    email "test100@example.com"
    username "test100"
    password "password"
    password_confirmation "password"
  end

  factory :admin do
    email "admin100@example.com"
    username "admin100"
    password "adminpassword"
    password_confirmation "adminpassword"
  end
end
