class RevisionStatusCalulator

  def thread_statuses(revision_root, revision=revision_root.nested_main.data.clone)
    revision[:threads] = revision_root.nested_threads.map(&:data)
    (0..(revision[:threads_count].to_i-1)).map do |index|
      thread = revision[:threads].find{|t| t[:thread_id] == index } || thread_result_stub
      calculate_thread_stats(thread)
    end
  end

  def global_status(revision_root)
    revision =  revision_root.nested_main.data.clone

    thread_statuses(revision_root, revision)

    thread_statuses = (revision[:threads] || []).map{|t| t[:status] }
    threads_count = revision[:threads_count].to_i

    threads_completed = thread_statuses.all?{|ts| ts[:completed] }
    completed = (thread_statuses.count == threads_count && threads_completed )
    failed = thread_statuses.any?{|ts| ts[:failed] }

    res = status(failed, completed)
    res
  end

  def thread_status(thread)
    failed = thread[:failed_examples] > 0
    completed = !thread[:in_progress]
    status(failed, completed)
  end

  private

  def calculate_thread_stats(thread)
    if !thread[:failed_examples]
      thread[:incomplete] = true
      thread[:failed_examples] = 0
    end
    thread[:in_progress] = (thread[:incomplete] || thread[:no_data])
    thread[:total_runned] = thread[:total_examples] - thread[:pending_examples]
    thread[:status] = thread_status(thread)
  end

  def thread_result_stub
    stub = {
        pending_examples: 0,
        total_examples: 0,
        total_runtime: 0,
        no_data: true,
    }
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