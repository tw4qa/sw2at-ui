require 'spec_helper'

describe FullRevision do

  context 'Fetching' do

    before :all do
      Fire.reset_tree!(FIREBASE_DATA)
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

  end

end

