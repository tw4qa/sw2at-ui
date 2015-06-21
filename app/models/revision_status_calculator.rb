class RevisionStatusCalulator

  def set_thread_statuses(revision_root)
    threads = revision_root.nested_threads
    (0..(revision_root.threads_count-1)).map do |index|
      thread = threads.find{|t| t.thread_id == index }
      calculate_and_update_thread_stats(thread || thread_result_stub)
    end
  end

  def set_status(revision_root)
    thread_statuses = set_thread_statuses(revision_root)
    threads_completed = thread_statuses.all?{|ts| ts[:completed] }

    completed = (thread_statuses.count == revision_root.threads_count && threads_completed )
    failed = thread_statuses.any?{|ts| ts[:failed] }

    revision_root.nested_status.set(status(failed, completed))
  end

  private

  def calculate_and_update_thread_stats(thread)
    unless thread.failed_examples
      thread.in_progress = true
      init_failed_examples(thread)
    end
    thread.total_runned = thread.total_examples - thread.pending_examples
    thread.status = thread_status(thread)
  end

  def thread_status(thread)
    failed = thread.failed_examples > 0
    completed = !thread.in_progress
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

  def init_failed_examples(thread)
    thread.failed_examples = (thread.tests||[]).select{|x|x.status == 'failed'}.count
  end

  STATUSES = {
      in_progress_success: {
          name: 'in_progress_success',
          label: 'In Progress',
          completed: false,
          failed: false,
      },
      in_progress_failed: {
          name: 'in_progress_failed',
          label: 'In Progress',
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
  }

  def status(failed, completed)
    id = if completed
           failed ? :completed_failed : :completed_passed
         else
           failed ? :in_progress_failed : :in_progress_success
         end
    STATUSES[id]
  end
end