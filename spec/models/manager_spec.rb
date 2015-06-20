require 'spec_helper'

describe RevisionManager do

  context 'Statuses' do
    before :each do
      Fire.connection.set(?/, data)
    end

    after :each do
      Fire.drop!
    end

    it 'should set basic statuses' do
      rev = Revision::Root.all.first
      status = rev.nested_status

      expect(status.value).to be_nil
      status.label = 'passed'
      status.save

      rev = Revision::Root.all.first
      expect(rev.nested_status.label).to eq('passed')
    end



  end

  context 'Fetching' do

    before :all do
      Fire.connection.set(?/, data)
    end

    after :all do
      Fire.drop!
    end

    it 'should fetch revisions' do
      expect(RevisionManager.fetch_revisions).to eq(
        [{'branch'=>'swat-edge-2',
         'name'=>'1434818198',
         'threads_count'=>'2',
         'time'=>1434818198,
         'user'=>'vitaliyt-pc',
         'threads'=>
             [{'failed_examples'=>0,
               'formatted_fails'=>'\nFailures:\n',
               'pending_examples'=>0,
               'thread_id'=>0,
               'thread_name'=>'Group',
               'total_examples'=>2,
               'total_runtime'=>6.864582575,
               'tests'=>[]},
              {'failed_examples'=>0,
               'formatted_fails'=>'\nFailures:\n',
               'pending_examples'=>0,
               'thread_id'=>1,
               'thread_name'=>'Unit',
               'total_examples'=>2,
               'total_runtime'=>7.09783131,
               'tests'=>[]}]}]
        )
    end

    it 'should fetch revision' do
      expect(RevisionManager.fetch_revision(branch: 'swat-edge-2', user: 'vitaliyt-pc', time: '1434818198')).to(
        eq(
          {'branch'=>'swat-edge-2',
           'name'=>'1434818198',
           'threads_count'=>'2',
           'time'=>1434818198,
           'user'=>'vitaliyt-pc',
           'threads'=>
               [{'failed_examples'=>0,
                 'formatted_fails'=>'\\nFailures:\\n',
                 'pending_examples'=>0,
                 'thread_id'=>0,
                 'thread_name'=>'Group',
                 'total_examples'=>2,
                 'total_runtime'=>6.864582575,
                 'tests'=>
                     [{'branch'=>'swat-edge-2',
                       'description'=>'should belong to a DeviceField',
                       'file_path'=>'./spec/models/attached_group_spec.rb',
                       'full_description'=>'AttachedGroup should belong to a DeviceField',
                       'id'=>'7sok8ycg',
                       'location'=>'./spec/models/attached_group_spec.rb:12',
                       'name'=>'1434818198',
                       'run_time'=>3.344149815,
                       'started_at'=>'2015-06-20T19:37:09+03:00',
                       'status'=>'passed',
                       'thread_id'=>0,
                       'threads_count'=>'2',
                       'time'=>1434818198,
                       'user'=>'vitaliyt-pc'},
                      {'branch'=>'swat-edge-2',
                       'description'=>'should have attached units',
                       'file_path'=>'./spec/models/attached_group_spec.rb',
                       'full_description'=>'AttachedGroup should have attached units',
                       'id'=>'q04i4tp8',
                       'location'=>'./spec/models/attached_group_spec.rb:5',
                       'name'=>'1434818198',
                       'run_time'=>3.52043276,
                       'started_at'=>'2015-06-20T19:37:13+03:00',
                       'status'=>'passed',
                       'thread_id'=>0,
                       'threads_count'=>'2',
                       'time'=>1434818198,
                       'user'=>'vitaliyt-pc'}]},
                {'failed_examples'=>0,
                 'formatted_fails'=>'\\nFailures:\\n',
                 'pending_examples'=>0,
                 'thread_id'=>1,
                 'thread_name'=>'Unit',
                 'total_examples'=>2,
                 'total_runtime'=>7.09783131,
                 'tests'=>
                     [{'branch'=>'swat-edge-2',
                       'description'=>'should save an image with thumbnails',
                       'file_path'=>'./spec/models/attached_unit_spec.rb',
                       'full_description'=>'AttachedUnit should save an image with thumbnails',
                       'id'=>'g1zmqzjt',
                       'location'=>'./spec/models/attached_unit_spec.rb:25',
                       'name'=>'1434818198',
                       'run_time'=>3.62353349,
                       'started_at'=>'2015-06-20T19:37:13+03:00',
                       'status'=>'passed',
                       'thread_id'=>1,
                       'threads_count'=>'2',
                       'time'=>1434818198,
                       'user'=>'vitaliyt-pc'},
                      {'branch'=>'swat-edge-2',
                       'description'=>'should save a text attachment',
                       'file_path'=>'./spec/models/attached_unit_spec.rb',
                       'full_description'=>'AttachedUnit should save a text attachment',
                       'id'=>'ndwvunky',
                       'location'=>'./spec/models/attached_unit_spec.rb:6',
                       'name'=>'1434818198',
                       'run_time'=>3.47429782,
                       'started_at'=>'2015-06-20T19:37:09+03:00',
                       'status'=>'passed',
                       'thread_id'=>1,
                       'threads_count'=>'2',
                       'time'=>1434818198,
                       'user'=>'vitaliyt-pc'}]}]}))
    end

  end


  def data
    {
        'Revision'=>
            {'swat-edge-2'=>
                 {'vitaliyt-pc'=>
                      {'1434818198_'=>
                           {'main'=>
                                {'branch'=>'swat-edge-2',
                                 'name'=>'1434818198',
                                 'threads_count'=>'2',
                                 'time'=>1434818198,
                                 'user'=>'vitaliyt-pc'},
                            'threads'=>
                                {'0_'=>
                                     {'failed_examples'=>0,
                                      'formatted_fails'=>'\nFailures:\n',
                                      'pending_examples'=>0,
                                      'thread_id'=>0,
                                      'thread_name'=>'Group',
                                      'total_examples'=>2,
                                      'total_runtime'=>6.864582575},
                                 '1_'=>
                                     {'failed_examples'=>0,
                                      'formatted_fails'=>'\nFailures:\n',
                                      'pending_examples'=>0,
                                      'thread_id'=>1,
                                      'thread_name'=>'Unit',
                                      'total_examples'=>2,
                                      'total_runtime'=>7.09783131}}}}}},
        'TestCase'=>
            {'swat-edge-2'=>
                 {'vitaliyt-pc'=>
                      {'1434818198_'=>
                           {'0_'=>
                                {'7sok8ycg'=>
                                     {'branch'=>'swat-edge-2',
                                      'description'=>'should belong to a DeviceField',
                                      'file_path'=>'./spec/models/attached_group_spec.rb',
                                      'full_description'=>
                                          'AttachedGroup should belong to a DeviceField',
                                      'id'=>'7sok8ycg',
                                      'location'=>'./spec/models/attached_group_spec.rb:12',
                                      'name'=>'1434818198',
                                      'run_time'=>3.344149815,
                                      'started_at'=>'2015-06-20T19:37:09+03:00',
                                      'status'=>'passed',
                                      'thread_id'=>0,
                                      'threads_count'=>'2',
                                      'time'=>1434818198,
                                      'user'=>'vitaliyt-pc'},
                                 'q04i4tp8'=>
                                     {'branch'=>'swat-edge-2',
                                      'description'=>'should have attached units',
                                      'file_path'=>'./spec/models/attached_group_spec.rb',
                                      'full_description'=>'AttachedGroup should have attached units',
                                      'id'=>'q04i4tp8',
                                      'location'=>'./spec/models/attached_group_spec.rb:5',
                                      'name'=>'1434818198',
                                      'run_time'=>3.52043276,
                                      'started_at'=>'2015-06-20T19:37:13+03:00',
                                      'status'=>'passed',
                                      'thread_id'=>0,
                                      'threads_count'=>'2',
                                      'time'=>1434818198,
                                      'user'=>'vitaliyt-pc'}},
                            '1_'=>
                                {'g1zmqzjt'=>
                                     {'branch'=>'swat-edge-2',
                                      'description'=>'should save an image with thumbnails',
                                      'file_path'=>'./spec/models/attached_unit_spec.rb',
                                      'full_description'=>
                                          'AttachedUnit should save an image with thumbnails',
                                      'id'=>'g1zmqzjt',
                                      'location'=>'./spec/models/attached_unit_spec.rb:25',
                                      'name'=>'1434818198',
                                      'run_time'=>3.62353349,
                                      'started_at'=>'2015-06-20T19:37:13+03:00',
                                      'status'=>'passed',
                                      'thread_id'=>1,
                                      'threads_count'=>'2',
                                      'time'=>1434818198,
                                      'user'=>'vitaliyt-pc'},
                                 'ndwvunky'=>
                                     {'branch'=>'swat-edge-2',
                                      'description'=>'should save a text attachment',
                                      'file_path'=>'./spec/models/attached_unit_spec.rb',
                                      'full_description'=>'AttachedUnit should save a text attachment',
                                      'id'=>'ndwvunky',
                                      'location'=>'./spec/models/attached_unit_spec.rb:6',
                                      'name'=>'1434818198',
                                      'run_time'=>3.47429782,
                                      'started_at'=>'2015-06-20T19:37:09+03:00',
                                      'status'=>'passed',
                                      'thread_id'=>1,
                                      'threads_count'=>'2',
                                      'time'=>1434818198,
                                      'user'=>'vitaliyt-pc'}}}}}}
    }
  end
end

