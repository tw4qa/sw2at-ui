require 'spec_helper'

describe Swat::UI::RSpecCommands::CommandsBuilder do

  it 'should build commands' do
    conf = {
      threads: [
        { name: 'Models', file_pattern: 'spec/models' },
        { name: 'Messaging', file_pattern: 'spec/messaging' },
        { name: 'TW', tags: [ 'tw' ] },
        { tag: 'thread_4' },
      ]
    }
    cb = Swat::UI::RSpecCommands::CommandsBuilder.new(conf, '06-01-2015_06-15')
    expect(cb.config).to eq(conf)
    expect(cb.threads_count).to eq(4)
    expect(cb.revision).to eq('06-01-2015_06-15')

    expect(cb.thread_scenarios.count).to eq(4)

    expect(cb.thread_scenario(conf[:threads][0], 0)).to eq({
      clean: 'TEST_ENV_NUMBER=0 rake db:drop',
      prepare: 'TEST_ENV_NUMBER=0 rake db:create && TEST_ENV_NUMBER=0 rake db:migrate',
      run: ('TEST_ENV_NUMBER=0 SWAT_CURRENT_REVISION=06-01-2015_06-15 ' +
        'SWAT_THREADS_COUNT=4 SWAT_CURRENT_THREAD_ID=0 SWAT_CURRENT_THREAD_NAME=Models ' +
        'rspec spec/models')
    })
  end

end
