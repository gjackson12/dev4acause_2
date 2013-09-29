FactoryGirl.define do
  factory :user do
    email 'john.smith@example.com'
    password 'bondra12'
    password_confirmation 'bondra12'
    first_name 'John'
    last_name 'Smith'
    city 'Washington'
    state 'District of Columbia'
    zipcode '20009'
  end
end