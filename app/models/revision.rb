class Revision
  include Fire
  extend Crypto

  class  << self

    def all
      resp = super()
      resp.map(&:values).map(&:first).flatten.map do |ns|
        decrypt_namespace(ns['id'])
      end
    end

    def add(opts)
      id = encrypt_namespace(opts)
      fire_client.push(full_collection(id), opts.merge(id: id)) if fire_client.get(full_collection(id)).body.nil?
    end

    def remove_by_time time
      TestCase.remove_by(time: time)
      remove_by{ |ns| ns[:time] == time }
    end

    def remove_branch branch
      TestCase.remove_by(branch: branch)
      remove_by{ |ns| ns[:branch] == branch }
    end

    def remove_user user
      TestCase.remove_by(user: user)
      remove_by{ |ns| ns[:user] == user }
    end


    def summary
      all_revisions = all
      [:branch, :user, :time].each_with_object({}) do |key, res|
        res[key] = all_revisions.map{|r| r[key] }
      end
    end

    private

    def remove_by &condition
      namespaces = all
      namespaces.select{|ns|
        condition.(ns)
      }.each do |ns|
        fire_client.delete(full_collection(encrypt_namespace(ns)))
      end
    end

    def full_collection(encrypted_namespace)
      collection+?/+encrypted_namespace
    end

  end

end
