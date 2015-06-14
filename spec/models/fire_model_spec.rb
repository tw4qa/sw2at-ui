require 'spec_helper'

describe 'Fire Models' do

  before :all do
    Fire.drop!
  end

  after :all do
    Fire.drop!
  end



  it 'should have a collection name' do
    fm = Fire::Model.new
    expect(fm.collection_name).to eq('Model')
  end

  it 'should have subclasses with own collection names' do
    class SampleModel < Fire::Model
    end

    class SecondModel < Fire::Model
      in_collection 'PerfectModel'
    end

    class ThirdModel < Fire::Model
      in_collection 'BestModel'
    end

    sm1 = SampleModel.new
    expect(sm1.collection_name).to eq('SampleModel')

    sm2 = SecondModel.new
    expect(sm2.collection_name).to eq('PerfectModel')

    sm3 = ThirdModel.new
    expect(sm3.collection_name).to eq('BestModel')
  end

end
