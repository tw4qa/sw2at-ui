require 'spec_helper'

describe Revision do

  it 'have a collection' do
    expect(Revision.collection).to eq('Revision')
  end

  context 'Data & Firebase API' do

    before :each do
      clean_firebase!
    end

    it 'should add and query' do
      expect(Revision.all).to eq([])
      ns = { branch: 'b', time: DateTime.parse('21/03/1990 10:00'), user: 'me', stats: nil }

      Revision.add(ns)
      expect(Revision.all).to eq([ns])
    end

    it 'should remove times' do
      expect(Revision.all).to eq([])
      ns1 = { branch: 'b', time: DateTime.parse('21/03/1990 10:00'), user: 'me', stats: nil }
      ns2 = { branch: 'b', time: DateTime.parse('22/03/1990 11:00'), user: 'me', stats: nil }

      Revision.add(ns1)
      Revision.add(ns2)

      expect(Revision.all).to eq([ns1, ns2])
      expect(Revision.test_cases(ns1)).to eq([])
      expect(Revision.test_cases(ns2)).to eq([])

      Revision.remove_by_time(ns1[:time])
      expect(Revision.all).to eq([ns2])
    end

    it 'should remove branches' do
      expect(Revision.all).to eq([])
      ns1 = { branch: 'a', time: DateTime.parse('21/03/1990 10:00'), user: 'me', stats: nil }
      ns2 = { branch: 'b', time: DateTime.parse('22/03/1990 11:00'), user: 'yu', stats: nil }
      ns3 = { branch: 'c', time: DateTime.parse('21/03/1990 12:00'), user: 'yu', stats: nil }
      ns4 = { branch: 'a', time: DateTime.parse('22/03/1990 11:00'), user: 'me', stats: nil }

      Revision.add(ns1)
      Revision.add(ns2)
      Revision.add(ns3)
      Revision.add(ns4)

      expect(Revision.all.sort_by(&:to_s)).to eq([ns1, ns2, ns3, ns4].sort_by(&:to_s))
      Revision.remove_branch(?a)
      expect(Revision.all).to eq([ns2, ns3])
    end

  end

end
