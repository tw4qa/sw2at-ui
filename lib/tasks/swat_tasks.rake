namespace :swat do

  namespace :ci do

    desc 'SWAT CI run'

    task run: :environment do
      scenarios = Swat::UI::RSpecCommands::CommandsBuilder.current_scenarios
      pp scenarios
      threads = scenarios.map do |scenario|
        Thread.new do
          `#{scenario[:clean]}`
          `#{scenario[:prepare]}`
          `#{scenario[:run]}`
        end
      end
      threads.each(&:join)
    end
  end

end

