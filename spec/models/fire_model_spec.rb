require 'spec_helper'

describe 'Fire Models' do

  before :all do
    Fire.drop!
  end

  after :all do
    Fire.drop!
  end



  it 'should have a collection & connection' do
    fm = Fire::Model.new
    expect(fm.collection_name).to eq('Model')
    expect(Fire::Model.connection).to be_a(Firebase::Client)
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

  it 'should build paths' do

    class TestModel < Fire::Model
      in_collection 'ExampleModel'
    end

    class ProdModel < Fire::Model
      in_collection 'ProductionModel'
      has_path_keys(:server_name, :date)
    end

    tm = TestModel.new
    expect(tm.id).to be
    expect(tm.path_values.count).to eq(1)

    tm.id = 'id-first'
    expect(tm.to_h).to eq({ id: 'id-first' })
    expect(tm.path_values).to eq([ 'id-first' ])

    tm = TestModel.new(id: 'id-second')
    expect(tm.id).to be
    expect(tm.path_values).to eq([ 'id-second' ])
  end

end
