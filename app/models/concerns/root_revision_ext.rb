module RootRevisionExt
  extend ActiveSupport::Concern

  def extend_path_data(args)
    attrs = self.class.prepare_hash(args)
    if attrs[:main]
      self.class.all_path_keys.each do |k|
        attrs[k] = attrs[:main][k.to_s]
      end
    end
    attrs
  end

end