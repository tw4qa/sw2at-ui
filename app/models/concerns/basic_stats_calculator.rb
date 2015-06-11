module BasicStatsCalculator

  def calculate_detailed_stats(revision_data); end

  def calculate_basic_stats(revision)
    (revision[:threads] || []).each do |t|
      calculate_thread_stats(revision, t)
    end
    revision[:status] = global_status(revision)
  end

  private

  def calculate_thread_stats(revision, thread)
    thread_result = (revision[:results] || []).find{|result| result['thread_id']  == thread['thread_id'] } || thread_result_stub(thread)
    thread['in_progress'] = thread_result['in_progress']
    thread['total_runned'] = thread_result['total_examples'] - thread_result['pending_examples']
    thread['total_failed'] = thread_result['failed_examples']
    thread['total_pending'] = thread_result['pending_examples']
    thread['status'] = thread_status(thread, thread_result)
    #binding.pry
  end

  def thread_result_stub(thread)
    stub = {
        'pending_examples' => 0,
        'total_examples' => thread['total_examples'],
        'failed_examples' => 0,
        'total_runtime' => 0,
        'in_progress' => true,
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
          label: 'PASSED',
          completed: true,
          failed: false,
      },
  }

  def thread_status(thread, result)
    failed = result['failed_examples'] > 0
    completed = !thread['in_progress']
    status(failed, completed)
  end

  def global_status(revision)
    thread_statuses = (revision[:threads] || []).map{|t| t['status'] }
    threads_count = revision[:threads_count].to_i

    threads_completed = thread_statuses.all?{|ts| ts[:completed] }
    completed = (thread_statuses.count == threads_count && threads_completed )
    failed = thread_statuses.any?{|ts| ts[:failed] }

    res = status(failed, completed)
    res
  end

  def status(failed, completed)
    id = if completed
           failed ? :completed_failed : :completed_passed
         else
           failed ? :in_progress_failed : :in_progress_success
         end
    STATUSES[id]
  end

end
