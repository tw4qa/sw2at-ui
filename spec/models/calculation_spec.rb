require 'spec_helper'

describe 'Calculations' do

  before :all do
    require Swat::Engine.root.join 'fixtures/firebase_collection'
    Fire.drop!
    Fire.fire_client.set(Fire::ROOT, FULL_COLLECTIONS)
  end

  after :all do
    Fire.drop!
  end

  it 'calculate failed statuses' do
    revision_opts = {
        :branch => 'swat-edge',
        :time => DateTime.parse('Wed, 10 Jun 2015 06:27:00 +0000'),
        :user => 'vitaliyt-pc'
    }
    @revision = Revision.query_one(revision_opts)

    expect(@revision)
    @thread_1 = @revision[:threads][0]

    expect(@thread_1).to eq(
      'in_progress' => nil,
      'status' => { :name=>'completed_failed', :label=>'Failed', failed: true, completed: true },
      'thread_id' => 0,
      'thread_name' => 'Questions & Submissions',
      'total_examples' => 20,
      'total_failed' => 5,
      'total_pending' => 0,
      'total_runned' => 20,
    )
    expect(@revision[:threads].map{|t| t['status'][:name] }).to eq([
      'completed_failed', 'completed_failed', 'completed_passed', 'completed_passed', 'completed_failed'
    ])

    expect(@revision[:status][:name]).to eq('completed_failed')
  end

  it 'should ' do
    revision_opts = {
        :branch => 'swat-edge',
        :time => DateTime.parse('2015-06-10T07:51:00+00:00'),
        :user => 'vitaliyt-pc'
    }
    @revision = Revision.query_one(revision_opts)
    expect(@revision[:threads].map{|t| t['in_progress'] }).to eq([true]*6)
    expect(@revision[:threads].map{|t| t['status'][:name] }).to eq([
        'in_progress_success', 'in_progress_success', 'in_progress_success', 'in_progress_success', 'in_progress_success', 'in_progress_success'
    ])
    expect(@revision[:status][:name]).to eq('in_progress_success')
  end


end