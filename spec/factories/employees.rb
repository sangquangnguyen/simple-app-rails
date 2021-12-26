FactoryBot.define do
  factory :employee do
    avatar { 'MyText' }
    fname { 'MyString' }
    lname { 'MyString' }
    birthday { '2021-12-20 15:00:27' }
    role { 'MyString' }
    email { 'MyString' }
    password { 'MyText' }
    organisation { nil }
  end
end
