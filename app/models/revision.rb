class Revision < Fire::SingleNestedModel

  class Root < Fire::Model
    in_collection 'Revision'
    has_path_keys :branch, :user
    set_id_key(:time)
    require_relative './concerns/root_revision_ext'
    include RootRevisionExt

    def initialize(args)
      super(extend_path_data(args))
    end

    def threads_count
      nested_main.threads_count.to_i
    end
  end

  nested_in Revision::Root, folder: 'main', parent_values: true
  set_id_key(:time)

  class Thread < Fire::NestedModel
    nested_in Revision::Root, folder: 'threads'
    set_id_key(:thread_id)
    has_path_keys
  end

  class Status < Fire::SingleNestedModel
    nested_in Revision::Root, folder: 'status'
  end

  def collect_started_thread(rspec_notification, data)
    object = data.merge( total_examples: rspec_notification.count )
    add_to_threads(object)
  end

  def add_to_threads(data)
    root.add_to_threads(data)
  end

  def threads
    load_root.nested_threads || []
  end

  def collect_ended_thread(rspec_notification, data)
    rspec_data = {
        total_examples: rspec_notification.examples.count,
        failed_examples: rspec_notification.failed_examples.count,
        pending_examples: rspec_notification.pending_examples.count,
        formatted_fails: rspec_notification.fully_formatted_failed_examples,
        total_runtime: rspec_notification.examples.map{|ex| ex.metadata[:execution_result].run_time }.inject(:+)
    }
    object = rspec_data.merge(data)
    add_to_threads(object)
  end

  class << self

    def add(params)
      create(params)
    end

  end

  private

  def root
    @root || Root.new(data)
  end

  def load_root
    @root = Root.take(data)
    return root unless @root
    Root.all_path_keys.each do |k|
      @root.send("#{k}=", self.send(k))
    end
    @root
  end

end

