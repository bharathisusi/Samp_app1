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


    user = User.new(email: email, password: password, first_name: firstname, last_name: lastname, is_admin: true)
    user.save!

  end
end
