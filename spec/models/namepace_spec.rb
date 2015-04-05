require 'spec_helper'

describe Namespace do

  it 'have a collection' do
    expect(Namespace.collection).to eq('Namespace')
  end

  context 'Data & Firebase API' do

    before :each do
      clean_firebase!
    end

    it 'should query data' do
      expect(Namespace.all).to eq([])

      ns = { branch: 'b', revision: DateTime.parse('21/03/1990 10:00'), user: 'me' }

      Namespace.add(ns)

      expect(Namespace.all).to eq([ns])
    end

  end


end
