class RevisionCleaner

  def clean_by(attribute, value)
    @paths = []

    if attribute.to_sym == :branch
      @paths = branch_paths(value)
    end

    if attribute.to_sym == :user
      @paths = user_paths(value)
    end

    if attribute.to_sym == :period
      @paths = period_paths(value)
    end

    @paths.each do |path|
      Fire::Model.connection.delete(path)
    end

    true
  end

  def period_paths(period)
    res = []
    all_revisions = Revision::Root.all
    revisions = all_revisions.select{|rev| Revision::Root.period(rev.time) == period }

    revisions.each do |rev|
      res << rev.path
      res << rev.path.gsub(Revision.collection_name, TestCase.collection_name)
    end

    res
  end

  def branch_paths(branch)
    res = []
    res << [ Revision.collection_name, Fire::Model.path_value_param(branch) ]*Fire::Model::LEVEL_SEPARATOR
    res << [ TestCase.collection_name, Fire::Model.path_value_param(branch) ]*Fire::Model::LEVEL_SEPARATOR
  end

  def user_paths(user)
    res = []
    all_revisions = Revision::Root.all
    revisions = all_revisions.select{|rev| rev.user == user }

    revisions.each do |rev|
      res << rev.path
      res << rev.path.gsub(Revision.collection_name, TestCase.collection_name)
    end

    res
  end

end