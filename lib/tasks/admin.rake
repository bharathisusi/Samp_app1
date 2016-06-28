namespace :admin do
  desc "TODO"
  task user_create: :environment do
    print "Enter your first name :"
    firstname = STDIN.gets.chomp
    print "Enter your last name :"
    lastname = STDIN.gets.chomp
    print "Enter your email :"
    email = STDIN.gets.chomp.strip
    print "Enter the password :"
    password = STDIN.gets.chomp.strip

    user = User.create(email: email, password: password, is_admin: true)
    user.build_profile(first_name: firstname, last_name: lastname).save!

  end
end
