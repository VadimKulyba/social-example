FactoryGirl.define do
  factory :user do
    name     'Kulyba Vadim'
    email    'kulyba.vadim@gmail.com'
    password '12345678'
    password_confirmation '12345678'

    factory :admin do
      admin true
    end
  end

  factory :micropost do
    content 'hello'
    user
  end
end