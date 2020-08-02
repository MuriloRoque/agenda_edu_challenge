namespace :token do


  desc 'create token for user'
  task create: :environment do
    User.where(token: nil).each do |user|
      user.update_attribute(:token,user.name.first(4).upcase + Time.now.strftime("%H:%M:%S").strip().to_s.gsub(/[^\d]/, ""))
    end
  end
end
