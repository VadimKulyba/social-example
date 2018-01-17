namespace :db do
  desc 'Fill database with sample data'
  task populate: :environment do
    # User.create!(name: 'Kulyba Vadim',
    #              email: 'kulyba.vadim@gmail.com',
    #              provider: 'default',
    #              admin: true,
    #              password: '12345678',
    #              password_confirmation: '12345678')
    # 99.times do |n|
    #   name  = Faker::Name.name
    #   email = "example-#{n+1}@railstutorial.org"
    #   password  = 'password'
    #   User.create!(name: name,
    #                email: email,
    #                provider: 'default',
    #                password: password,
    #                password_confirmation: password)
    # end
    users = User.find(1)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.microposts.create!(content: content)
    end
  end
end