require 'spec_helper'

describe Swat::UI::RSpecCommands::CommandsBuilder do

  context 'Simplest situation' do


    it 'should build commands if threads are not set' do
      t = '2015-06-10 10:49 UTC'
      cb = Swat::UI::RSpecCommands::CommandsBuilder.new({}, t)
      expect(cb.thread_scenarios).to eq([
          :clean=>"RAILS_ENV='test' TEST_ENV_NUMBER='0' rake db:drop",
          :prepare=>
              "RAILS_ENV='test' TEST_ENV_NUMBER='0' rake db:create && RAILS_ENV='test' TEST_ENV_NUMBER='0' rake db:migrate",
          :run=> "TEST_ENV_NUMBER='0' SWAT_CURRENT_REVISION_NAME='2015-06-10 10:49 UTC' SWAT_CURRENT_REVISION_TIME='2015-06-10 10:49 UTC' SWAT_THREADS_COUNT='1' SWAT_CURRENT_THREAD_ID='0' SWAT_CURRENT_THREAD_NAME='Full' rspec"
      ])
    end

  end

  context 'Multiple Threads' do
    before :all do
      @conf = {
          threads: [
              { name: 'Models', file_pattern: 'spec/models' },
              { name: 'Messaging', file_pattern: 'spec/features/messaging' },
              { name: 'TW', tags: [ 'tw', 'tw1' ] },
              { tags: 'thread_4' },
          ]
      }
      @time = '06-01-2015_06-15'
    end

    it 'should build commands' do
      conf = @conf
      cb = Swat::UI::RSpecCommands::CommandsBuilder.new(conf, @time, 'Great Revision')

      expect(cb.config).to eq(conf)
      expect(cb.threads_count).to eq(4)
      expect(cb.time).to eq('06-01-2015_06-15')

      expect(cb.thread_scenarios.count).to eq(4)

      expect(cb.thread_scenario(conf[:threads][0], 0)).to eq({
        clean: "RAILS_ENV='test' TEST_ENV_NUMBER='0' rake db:drop",
        prepare: "RAILS_ENV='test' TEST_ENV_NUMBER='0' rake db:create && RAILS_ENV='test' TEST_ENV_NUMBER='0' rake db:migrate",
        run: "TEST_ENV_NUMBER='0' SWAT_CURRENT_REVISION_NAME='Great Revision' SWAT_CURRENT_REVISION_TIME='06-01-2015_06-15' SWAT_THREADS_COUNT='4' SWAT_CURRENT_THREAD_ID='0' SWAT_CURRENT_THREAD_NAME='Models' rspec spec/models"
      })

      expect(cb.thread_scenario(conf[:threads][1], 1)).to eq({
         clean: "RAILS_ENV='test' TEST_ENV_NUMBER='1' rake db:drop",
         prepare: "RAILS_ENV='test' TEST_ENV_NUMBER='1' rake db:create && RAILS_ENV='test' TEST_ENV_NUMBER='1' rake db:migrate",
         run: "TEST_ENV_NUMBER='1' SWAT_CURRENT_REVISION_NAME='Great Revision' SWAT_CURRENT_REVISION_TIME='06-01-2015_06-15' SWAT_THREADS_COUNT='4' SWAT_CURRENT_THREAD_ID='1' SWAT_CURRENT_THREAD_NAME='Messaging' rspec spec/features/messaging"
     })

      expect(cb.thread_scenario(conf[:threads][2], 2)).to eq({
         clean: "RAILS_ENV='test' TEST_ENV_NUMBER='2' rake db:drop",
         prepare: "RAILS_ENV='test' TEST_ENV_NUMBER='2' rake db:create && RAILS_ENV='test' TEST_ENV_NUMBER='2' rake db:migrate",
         run: "TEST_ENV_NUMBER='2' SWAT_CURRENT_REVISION_NAME='Great Revision' SWAT_CURRENT_REVISION_TIME='06-01-2015_06-15' SWAT_THREADS_COUNT='4' SWAT_CURRENT_THREAD_ID='2' SWAT_CURRENT_THREAD_NAME='TW' rspec --tag tw --tag tw1"
      })

      expect(cb.thread_scenario(conf[:threads][3], 3)).to eq({
         clean: "RAILS_ENV='test' TEST_ENV_NUMBER='3' rake db:drop",
         prepare: "RAILS_ENV='test' TEST_ENV_NUMBER='3' rake db:create && RAILS_ENV='test' TEST_ENV_NUMBER='3' rake db:migrate",
         run: "TEST_ENV_NUMBER='3' SWAT_CURRENT_REVISION_NAME='Great Revision' SWAT_CURRENT_REVISION_TIME='06-01-2015_06-15' SWAT_THREADS_COUNT='4' SWAT_CURRENT_THREAD_ID='3' SWAT_CURRENT_THREAD_NAME='Thread#4' rspec --tag thread_4"
      })

      expect(cb.thread_scenarios.count).to eq(4)
    end

  end

end
