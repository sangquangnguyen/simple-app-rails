FactoryBot.define do
  factory :employee do
    avatar { 'Avatar URL' }
    fname { 'Sang' }
    lname { 'Nguyen' }
    birthday { '2021-12-20 15:00:27' }
    role { 'system' }
    email { 'test@gmail.com' }
    password { 'abc' }
    organisation { nil }
  end
end
