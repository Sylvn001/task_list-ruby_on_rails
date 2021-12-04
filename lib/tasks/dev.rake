namespace :dev do

  DEFAULT_PASSWORD = 123456


  desc "TODO"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Droping DB if exists...", "Successful!!") do
        puts %x(rails db:drop)
      end

      show_spinner("Creating DB...") do
        puts %x(rails db:create)
      end

      show_spinner("Running migrations...") do
        puts %x(rails db:migrate)
      end

      show_spinner("Creating default admin...") do
        puts %x(rails dev:add_default_admin)
      end

      show_spinner("Creating default user...") do
        puts %x(rails dev:add_default_user)
      end

    end
  end

  desc "Create default admin"
  task add_default_admin: :environment do
    Admin.create!(
      email: 'admin@admin.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc "Create default user"
  task add_default_user: :environment do
    User.create!(
      email: 'user@user.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD

    )
  end

  private
    def show_spinner(msg_start, msg_end = "Successful!!")
      spinner = TTY::Spinner.new("[:spinner] #{msg_start}", format: :pulse_2)
      spinner.auto_spin
      yield
      spinner.success("(#{msg_end})")
    end
end
