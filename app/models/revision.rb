class Revision < Fire::Model

  has_path_keys :branch, :user
  set_id_key(:time)

  class << self

    def add(params)
      new(params).save
    end

  end

  class Thread < Fire::NestedModel
    nested_in Revision, folder: 'threads'
    has_path_keys
  end

end
