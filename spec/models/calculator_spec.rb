require 'spec_helper'

describe FullRevision do

  context 'Calculations' do

    context 'Statuses' do

      before :each do
        Fire.reset_tree!(FIREBASE_DATA)
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

      it 'should calculate basic status (completed_passed)' do
        rev = Revision::Root.all.first

        ts = RevisionStatusCalulator.new.thread_statuses(rev)
        expect(ts).to eq(
            [{:name=>"completed_passed",
              :label=>"Passed",
              :completed=>true,
              :failed=>false},
             {:name=>"completed_passed",
              :label=>"Passed",
              :completed=>true,
              :failed=>false}]
        )

        status = RevisionStatusCalulator.new.global_status(rev)
        expect(status).to eq({name: "completed_passed", label: "Passed", completed: true, failed: false})
      end

      it 'should calculate basic status (completed_failed)' do
        rev = Revision::Root.all.first

        t = rev.nested_threads.first
        t.failed_examples = 5
        t.save

        rev = Revision::Root.all.first

        ts = RevisionStatusCalulator.new.thread_statuses(rev)
        expect(ts).to eq(
            [{:name=>"completed_failed",
              :label=>"Failed",
              :completed=>true,
              :failed=>true},
             {:name=>"completed_passed",
              :label=>"Passed",
              :completed=>true,
              :failed=>false}]
        )

        status = RevisionStatusCalulator.new.global_status(rev)
        expect(status).to eq({name: "completed_failed", label: "Failed", completed: true, failed: true})
      end

      it 'should calculate basic status (in_progress_failed)' do
        rev = Revision::Root.all.first

        t1 = rev.nested_threads.first
        t1.failed_examples = 5
        t1.save

        t2 = rev.nested_threads.last
        t2.failed_examples = nil
        t2.save

        rev = Revision::Root.all.first

        ts = RevisionStatusCalulator.new.thread_statuses(rev)
        expect(ts).to eq(
            [{:name=>"completed_failed",
              :label=>"Failed",
              :completed=>true,
              :failed=>true},
             {:name=>"in_progress_success",
              :label=>"In Progress",
              :completed=>false,
              :failed=>false}]
        )
        status = RevisionStatusCalulator.new.global_status(rev)
        expect(status).to eq({name: "in_progress_failed", label: "In Progress", completed: false, failed: true})
      end


      it 'should calculate basic status (in_progress_success)' do
        rev = Revision::Root.all.first
        main = rev.nested_main
        main.threads_count = 3
        main.save

        rev = Revision::Root.all.first

        ts = RevisionStatusCalulator.new.thread_statuses(rev)
        expect(ts).to eq(
            [{:name=>"completed_passed",
              :label=>"Passed",
              :completed=>true,
              :failed=>false},
             {:name=>"completed_passed",
              :label=>"Passed",
              :completed=>true,
              :failed=>false},
             {:name=>"in_progress_success",
              :label=>"In Progress",
              :completed=>false,
              :failed=>false}
            ]
        )
        status = RevisionStatusCalulator.new.global_status(rev)
        expect(status).to eq({name: "in_progress_success", label: "In Progress", completed: false, failed: false})
      end

    end

  end

end
