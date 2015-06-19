require 'spec_helper'

describe Revision do

  before :each do
    Fire.drop!
    @params = { branch: 'b', time: '1990-03-21T10:00', user: 'me' }
  end

  it 'should have a colelction' do
    expect(Revision.new.collection_name).to eq('Revision')
  end


  it 'should add an object' do
    Revision.add(@params)

    revision = Revision.take(@params)

    expect(revision.time).to be
    expect(revision.branch).to eq(?b)
    expect(revision.user).to eq('me')

    expect(revision.data.keys).to eq([ :branch, :time, :user ])
  end

  it 'should create a thread object' do
    Revision.add(@params)

    Revision::Thread.create(@params.merge(id: 2, status: 'failed'))

    revision = Revision.take(@params)
    expect(revision.threads.count).to eq(1)
  end

  it 'should add a thread object' do
    Revision.add(@params)

    revision = Revision.take(@params)

    revision.add_to_threads(id: 1, status: 'started')
    revision.add_to_threads(id: 2, status: 'failed')

    revision = Revision.take(@params)

    expect(revision.nested_threads.count).to eq(2)

    expect(revision.nested_threads.map(&:id)).to eq([1, 2])
    expect(revision.nested_threads.map(&:status)).to eq(['started', 'failed'])

    revision.add_to_threads(id: 1, status: 'passed')
    thread = revision.nested_threads.last

    thread.status = 'perfect'
    thread.save

    expect(Revision.take(@params).nested_threads.map(&:status)).to eq(['passed', 'perfect'])
  end

end