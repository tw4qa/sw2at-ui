namespace :swat do

  namespace :ci do

    desc 'SWAT CI run'

    task run: :environment do
      scenarios = Swat::UI::RSpecCommands::CommandsBuilder.current_scenarios
      threads = scenarios.map do |scenario|
        Thread.new do
          logged_command(scenario, :clean)
          logged_command(scenario, :prepare)
          logged_command(scenario, :run)
        end
      end

      threads.each(&:join)
    end

    def logged_command(scenario, command)
      `#{scenario[command]}`
    end
  end

end

