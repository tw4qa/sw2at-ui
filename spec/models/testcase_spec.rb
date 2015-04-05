require 'spec_helper'

describe TestCase do

  it 'have a collection' do
    expect(TestCase.collection).to eq('TestCase')
  end

  it 'should call firebase' do
    puts Swat::UI.config.options
  end

end