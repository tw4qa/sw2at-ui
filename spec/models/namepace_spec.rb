require 'spec_helper'

describe Namespace do

  it 'have a collection' do
    expect(Namespace.collection).to eq('Namespace')
  end

  context 'Data & Firebase API' do

    before :each do
      clean_firebase!
    end

    it 'should add and query' do
      expect(Namespace.all).to eq([])
      ns = { branch: 'b', revision: DateTime.parse('21/03/1990 10:00'), user: 'me' }

      Namespace.add(ns)
      expect(Namespace.all).to eq([ns])
    end

    it 'should remove revisions' do
      expect(Namespace.all).to eq([])
      ns1 = { branch: 'b', revision: DateTime.parse('21/03/1990 10:00'), user: 'me' }
      ns2 = { branch: 'b', revision: DateTime.parse('22/03/1990 11:00'), user: 'me' }

      Namespace.add(ns1)
      Namespace.add(ns2)

      expect(Namespace.all).to eq([ns1, ns2])

      Namespace.remove_revision(ns1[:revision])
      expect(Namespace.all).to eq([ns2])
    end

    it 'should remove branches' do
      expect(Namespace.all).to eq([])
      ns1 = { branch: 'a', revision: DateTime.parse('21/03/1990 10:00'), user: 'me' }
      ns2 = { branch: 'b', revision: DateTime.parse('22/03/1990 11:00'), user: 'yu' }
      ns3 = { branch: 'c', revision: DateTime.parse('21/03/1990 12:00'), user: 'yu' }
      ns4 = { branch: 'a', revision: DateTime.parse('22/03/1990 11:00'), user: 'me' }

      Namespace.add(ns1)
      Namespace.add(ns2)
      Namespace.add(ns3)
      Namespace.add(ns4)

      expect(Namespace.all).to eq([ns1, ns2, ns3, ns4])
      Namespace.remove_branch(?a)
      expect(Namespace.all).to eq([ns2, ns3])
    end
  end

end
