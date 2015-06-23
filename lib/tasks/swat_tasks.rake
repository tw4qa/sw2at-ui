namespace :swat do

  namespace :ci do

    desc 'SWAT CI clean - drop all test databases'
    task clean: :environment do
      scenarios = Swat::UI::RSpecCommands::CommandsBuilder.current_scenarios
      threads = scenarios.map do |scenario|
        Thread.new do
          run_command(scenario, :clean)
        end
      end

      threads.each(&:join)
    end

    desc 'SWAT CI run - create all test databases and migrate them. Then run tests in parallel'
    task run: :environment do
      scenarios = Swat::UI::RSpecCommands::CommandsBuilder.current_scenarios
      threads = scenarios.map do |scenario|
        Thread.new do
          run_command(scenario, :prepare)
          run_command(scenario, :run)
        end
      end

      threads.each(&:join)
    end

    def run_command(scenario, command)
      `#{scenario[command]}`
    end
  end

end

