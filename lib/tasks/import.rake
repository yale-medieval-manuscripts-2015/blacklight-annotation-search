namespace :import do

  desc "imports cas user data from a csv file"
  task :users => :environment do
    require 'csv'
    CSV.foreach('importData/users.csv') do |row|

      email = row[0] + "@yale.edu"
      password = "CAS User"
      reset_password_token = ''
      reset_password_sent_at = ''
      remember_created_at = ''
      sign_in_count = ''
      current_sign_in_at = ''
      last_sign_in_at = ''
      current_sign_in_ip = ''
      last_sign_in_ip = ''
      created_at = ''
      updated_at = ''
      guest = ''
      provider = 'cas'
      uid = row[0]

      puts row.inspect
      puts "Provider: ", provider,"uid: ",uid,"email", email
      @user = User.create(provider: provider, uid: uid, encrypted_password: password, email: email)
      @user.save!(options={validate: false})
      puts "user.provider = ", @user.provider
    end
  end
end
