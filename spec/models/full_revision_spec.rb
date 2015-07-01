require 'spec_helper'

describe FullRevision do

  context 'Fetching' do

    before :each do
      Fire.reset_tree!(FIREBASE_DATA)
      allow_any_instance_of(RevisionStatusCalulator).to receive(:old_build?).and_return(false)
    end

    it 'should fetch revisions' do
      json = FullRevision.revisions_json
      expect(json).to eq(
        [{:branch=>"swat-edge-2",
          :name=>"1434818198",
          :threads_count=>"2",
          :time=>1434818198,
          :user=>"vitaliyt-pc",
          :threads=>
              [{:failed_examples=>0,
                :formatted_fails=>"\\nFailures:\\n",
                :pending_examples=>0,
                :thread_id=>0,
                :thread_name=>"Group",
                :total_examples=>2,
                total_failed: 0,
                :total_runtime=>6.864582575,
                :tests=>[],
                :total_runned=>2,
                :status=>
                    {:name=>"completed_passed",
                     :label=>"Passed",
                     :completed=>true,
                     :failed=>false}},
               {:failed_examples=>0,
                :formatted_fails=>"\\nFailures:\\n",
                :pending_examples=>0,
                :thread_id=>1,
                :thread_name=>"Unit",
                :total_examples=>2,
                total_failed: 0,
                :total_runtime=>7.09783131,
                :tests=>[],
                :total_runned=>2,
                :status=>
                    {:name=>"completed_passed",
                     :label=>"Passed",
                     :completed=>true,
                     :failed=>false}}],
          :status=>
              {:name=>"completed_passed",
               :label=>"Passed",
               :completed=>true,
               :failed=>false}
         }]
        )
    end

    it 'should fetch a revision' do
      json = FullRevision.revision_json(branch: 'swat-edge-2', user: 'vitaliyt-pc', time: '1434818198')
      expect(json).to(
        eq({:branch=>"swat-edge-2",
            :name=>"1434818198",
            :threads_count=>"2",
            :time=>1434818198,
            :user=>"vitaliyt-pc",
            :threads=>
            [{:failed_examples=>0,
              :formatted_fails=>"\\nFailures:\\n",
              :pending_examples=>0,
              :thread_id=>0,
              :thread_name=>"Group",
              :total_examples=>2,
              total_failed: 0,
              :total_runtime=>6.864582575,
              :tests=>
                  [{:branch=>"swat-edge-2",
                    :description=>"should belong to a DeviceField",
                    :file_path=>"./spec/models/attached_group_spec.rb",
                    :full_description=>"AttachedGroup should belong to a DeviceField",
                    :id=>"7sok8ycg",
                    :location=>"./spec/models/attached_group_spec.rb:12",
                    :name=>"1434818198",
                    :run_time=>3.344149815,
                    :started_at=>"2015-06-20T19:37:09+03:00",
                    :status=>"passed",
                    :thread_id=>0,
                    :thread_name=>"Group",
                    :threads_count=>"2",
                    :time=>1434818198,
                    :user=>"vitaliyt-pc"},
                   {:branch=>"swat-edge-2",
                    :description=>"should have attached units",
                    :file_path=>"./spec/models/attached_group_spec.rb",
                    :full_description=>"AttachedGroup should have attached units",
                    :id=>"q04i4tp8",
                    :location=>"./spec/models/attached_group_spec.rb:5",
                    :name=>"1434818198",
                    :run_time=>3.52043276,
                    :started_at=>"2015-06-20T19:37:13+03:00",
                    :status=>"passed",
                    :thread_id=>0,
                    :thread_name=>"Group",
                    :threads_count=>"2",
                    :time=>1434818198,
                    :user=>"vitaliyt-pc"}],
              :total_runned=>2,
              :status=>
                  {:name=>"completed_passed",
                   :label=>"Passed",
                   :completed=>true,
                   :failed=>false}},
             {:failed_examples=>0,
              :formatted_fails=>"\\nFailures:\\n",
              :pending_examples=>0,
              :thread_id=>1,
              :thread_name=>"Unit",
              :total_examples=>2,
              total_failed: 0,
              :total_runtime=>7.09783131,
              :tests=>
                  [{:branch=>"swat-edge-2",
                    :description=>"should save an image with thumbnails",
                    :file_path=>"./spec/models/attached_unit_spec.rb",
                    :full_description=>"AttachedUnit should save an image with thumbnails",
                    :id=>"g1zmqzjt",
                    :location=>"./spec/models/attached_unit_spec.rb:25",
                    :name=>"1434818198",
                    :run_time=>3.62353349,
                    :started_at=>"2015-06-20T19:37:13+03:00",
                    :status=>"passed",
                    :thread_id=>1,
                    :thread_name=>"Unit",
                    :threads_count=>"2",
                    :time=>1434818198,
                    :user=>"vitaliyt-pc"},
                   {:branch=>"swat-edge-2",
                    :description=>"should save a text attachment",
                    :file_path=>"./spec/models/attached_unit_spec.rb",
                    :full_description=>"AttachedUnit should save a text attachment",
                    :id=>"ndwvunky",
                    :location=>"./spec/models/attached_unit_spec.rb:6",
                    :name=>"1434818198",
                    :run_time=>3.47429782,
                    :started_at=>"2015-06-20T19:37:09+03:00",
                    :status=>"passed",
                    :thread_id=>1,
                    :thread_name=>"Unit",
                    :threads_count=>"2",
                    :time=>1434818198,
                    :user=>"vitaliyt-pc"}],
              :total_runned=>2,
              :status=>
                  {:name=>"completed_passed",
                   :label=>"Passed",
                   :completed=>true,
                   :failed=>false}}],
            :status=>
            {:name=>"completed_passed",
             :label=>"Passed",
             :completed=>true,
             :failed=>false}}
      ))
    end

    it 'should update status after fetch(completed passed)' do

      revision_root = Revision::Root.take(branch: 'swat-edge-2', user: 'vitaliyt-pc', time: 1434818198)
      expect(revision_root.nested_status.name).to be_nil
      expect(revision_root.nested_threads.map{|nt| nt.status }).to eq([nil, nil])

      FullRevision.fetch(branch: 'swat-edge-2', user: 'vitaliyt-pc', time: '1434818198')

      revision_root.reload
      expect(revision_root.nested_status.name).to eq('completed_passed')
      expect(revision_root.nested_threads.map{|nt| nt.status[:name] }).to eq(['completed_passed', 'completed_passed'])
    end

    it 'should update status after fetch(in_progress_failed)' do
      revision_root = Revision::Root.take(branch: 'swat-edge-2', user: 'vitaliyt-pc', time: 1434818198)

      th = revision_root.nested_threads.last
      th.failed_examples = nil
      th.save

      test = TestCase.all.last
      test.status = 'failed'
      test.save

      revision_root.reload

      expect(revision_root.nested_status.name).to be_nil
      expect(revision_root.nested_threads.map{|nt| nt.status }).to eq([nil, nil])

      FullRevision.fetch(branch: 'swat-edge-2', user: 'vitaliyt-pc', time: '1434818198')

      revision_root.reload
      expect(revision_root.nested_status.name).to eq('in_progress_failed')
      expect(revision_root.nested_threads.map{|nt| nt.status[:name] }).to eq(['completed_passed', 'in_progress_failed'])
    end

    it 'should update status after fetch(in_progress_success -> in_progress_failed -> completed_failed )' do
      revision_root = Revision::Root.take(branch: 'swat-edge-2', user: 'vitaliyt-pc', time: 1434818198)

      th1 = revision_root.nested_threads.first
      th1.failed_examples = nil
      th1.save

      th2 = revision_root.nested_threads.last
      th2.failed_examples = nil
      th2.save

      revision_root.reload

      expect(revision_root.nested_status.name).to be_nil
      expect(revision_root.nested_threads.map{|nt| nt.status }).to eq([nil, nil])

      # List fetch shows correct result
      expect(FullRevision.fetch_all.first.nested_threads.map{|nt| nt.status[:name] }).to eq(['in_progress_success', 'in_progress_success'])

      # Fetch
      FullRevision.fetch(branch: 'swat-edge-2', user: 'vitaliyt-pc', time: '1434818198')

      revision_root.reload
      expect(revision_root.nested_status.name).to eq('in_progress_success')

      # Full fetch shows correct result
      expect(revision_root.nested_threads.map{|nt| nt.status[:name] }).to eq(['in_progress_success', 'in_progress_success'])
      # List fetch shows correct result
      expect(FullRevision.fetch_all.first.nested_threads.map{|nt| nt.status[:name] }).to eq(['in_progress_success', 'in_progress_success'])

      test = TestCase.query(id: 'g1zmqzjt').first
      test.status = 'failed'
      test.save

      # Fetch
      FullRevision.fetch(branch: 'swat-edge-2', user: 'vitaliyt-pc', time: '1434818198')

      revision_root.reload
      expect(revision_root.nested_status.name).to eq('in_progress_failed')
      # Full fetch shows correct result
      expect(revision_root.nested_threads.map{|nt| nt.status[:name] }).to eq(['in_progress_success', 'in_progress_failed'])
      # List fetch shows correct result
      expect(FullRevision.fetch_all.first.nested_threads.map{|nt| nt.status[:name] }).to eq(['in_progress_success', 'in_progress_failed'])


      th1.failed_examples = 0
      th1.save

      th2.failed_examples = 2
      th2.save

      # Fetch
      FullRevision.fetch(branch: 'swat-edge-2', user: 'vitaliyt-pc', time: '1434818198')

      revision_root.reload
      expect(revision_root.nested_status.name).to eq('completed_failed')
      expect(revision_root.nested_threads.map{|nt| nt.status[:name] }).to eq(['completed_passed', 'completed_failed'])

      expect(FullRevision.fetch_all.first.nested_threads.map{|nt| nt.status[:name] }).to eq(['completed_passed', 'completed_failed'])
    end

  end

end

