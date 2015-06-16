class Revision < Fire::Model

  has_path_keys :branch, :user

  def threads
    result = super()
    result.nil? ? [] : result.values.map{|x| thread(x) }
  end

  def update_thread(thread_object)
    thread(thread_object).save
  end

  def thread_attrs(custom_thread_attrs)
    path_data.merge(custom_thread_attrs)
  end

  def thread(custom_thread_attrs)
    Thread.new(thread_attrs(custom_thread_attrs))
  end

  class << self

    def add(params)
      new(params).save
    end

    def id_key
      :time
    end

  end

  class Thread < Fire::Model
    in_collection 'Revision'
    has_path_keys :branch, :user, :time, :folder

    def folder
      'threads'
    end

    def data
      custom_data(to_h).merge(id: id)
    end
  end

end
