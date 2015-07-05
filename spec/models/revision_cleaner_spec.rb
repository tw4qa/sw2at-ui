require 'spec_helper'

describe RevisionCleaner do

  before :each do
    Fire.reset_tree!(FIREBASE_DATA)
  end

  it 'should clean by branch' do
    RevisionCleaner.new.clean_by('branch', 'swat-edge-2')
    expect(Revision::Root.all.count).to eq(0)
    expect(TestCase.all.count).to eq(0)
  end

  it 'should clean by user' do
    RevisionCleaner.new.clean_by('user', 'vitaliyt-pc')
    expect(Revision::Root.all.count).to eq(0)
    expect(TestCase.all.count).to eq(0)
  end

  it 'should clean by period' do
    RevisionCleaner.new.clean_by('period', '06/20/2015')
    expect(Revision::Root.all.count).to eq(0)
    expect(TestCase.all.count).to eq(0)
  end

end