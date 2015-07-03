class RevisionStatusCalulator

  attr_reader :revision_root

  def initialize(revision_root)
    @revision_root = revision_root
  end

  def set_thread_statuses
    threads = revision_root.nested_threads
    (0..(revision_root.threads_count-1)).map do |index|
      thread = threads.find{|t| t.thread_id == index }
      calculate_and_modify_thread_status(thread || thread_result_stub)
    end
  end

  def set_status
    thread_statuses = set_thread_statuses
    threads_completed = thread_statuses.all?{|ts| ts[:completed] }

    completed = (thread_statuses.count == revision_root.threads_count && threads_completed )
    failed = thread_statuses.any?{|ts| ts[:failed] }

    revision_root.nested_status.set(status(failed, completed, old_build?))
  end

  TERMINATION_TIME = 2 # days

  def old_build?
    diff = TimeDifference.between(Time.now.utc, Time.at(revision_root.time)).in_hours
    diff >= TERMINATION_TIME
  end

  private

  def calculate_and_modify_thread_status(thread)
    init_total_failed(thread)
    thread.total_runned = thread.total_examples.to_i - thread.pending_examples.to_i
    thread.status = thread_status(thread)
    thread.status
  end

  def thread_status(thread)
    failed_aleady =  thread[:status][:failed] rescue false
    completed_already = thread[:status][:completed] rescue false

    failed = (thread.total_failed > 0) || failed_aleady
    completed = !thread.in_progress  || completed_already
    status(failed, completed)
  end

  def thread_result_stub
    stub = {
        pending_examples: 0,
        total_examples: 0,
        total_runtime: 0,
        in_progress: true,
    }
    OpenStruct.new(stub)
  end

  def init_total_failed(thread)
    tests = thread.tests || []
    failed_tests =  tests.select{|x|x.status == 'failed'}.count
    unless thread.failed_examples
      if (thread.tests||[]).count == thread.total_examples
        thread.failed_examples = thread.total_failed = failed_tests
      end
      thread.in_progress = true
      thread.total_failed = failed_tests
    else
      if failed_tests > 0 && thread.failed_examples == 0
        thread.failed_examples = failed_tests
      end
      thread.total_failed = thread.failed_examples
    end
  end

  STATUSES = {
      in_progress_success: {
          name: 'in_progress_success',
          label: 'Started',
          completed: false,
          failed: false,
      },
      in_progress_failed: {
          name: 'in_progress_failed',
          label: 'Started',
          completed: false,
          failed: true,
      },
      completed_failed: {
          name: 'completed_failed',
          label: 'Failed',
          completed: true,
          failed: true,
      },
      completed_passed: {
          name: 'completed_passed',
          label: 'Passed',
          completed: true,
          failed: false,
      },
      terminated: {
          name: 'terminated',
          label: 'Terminated',
          completed: true,
          failed: true,
      }
  }

  def status(failed, completed, old_build=false)
    id = if completed
           failed ? :completed_failed : :completed_passed
         else
           failed ? :in_progress_failed : :in_progress_success
         end
    status_candidate = STATUSES[id]

    return STATUSES[:terminated] if (old_build && !status_candidate[:completed])

    status_candidate
  end

end