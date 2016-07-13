namespace :profile do
  desc "TODO"
  task update_profile: :environment do
    User.all.each do |u|
      if u.profile.blank?
        p = u.build_profile(first_name: u.first_name, last_name: u.last_name)
        p.save!
      else
         u.profile.update(first_name: u.first_name, last_name: u.last_name)
      end
    end



  end

end
