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

  factory :nonprofit do
    name 'American Red Cross'
    ein_num '1-1111111'
    city 'Washington'
    state 'District of Columbia'
    description_mission '
      The American Red Cross prevents and alleviates human suffering 
      in the face of emergencies by mobilizing the power of volunteers 
      and the generosity of donors.'
    cause 'Disaster Relief'
    date_founded 'May 21st 1881'
    phone_number '202-111-1111'
    fax_number '202-111-1111'
    street_address '1234 Constiution Avenue'
    street_address_2 '4th floor'
    zipcode '20009'
    email_address 'john@americanredcross.com'
    website_string 'http://www.redcross.org'
  end
end