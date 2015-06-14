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

  it 'should build paths for simple subclasses' do

    class TestModel < Fire::Model
      in_collection 'ExampleModel'
    end

    tm = TestModel.new
    expect(tm.id).to be
    expect(tm.path_values.count).to eq(1)

    tm.id = 'id_first'
    expect(tm.to_h).to eq({ id: 'id_first' })
    expect(tm.path_values).to eq([ 'id_first' ])
    expect(tm.path).to eq('ExampleModel/id_first')

    tm = TestModel.new(id: 'id_second')
    expect(tm.id).to be
    expect(tm.path_values).to eq([ 'id_second' ])
    expect(tm.path).to eq('ExampleModel/id_second')
  end

  it 'should build paths for subclasses with custom path keys' do

    class Address < Fire::Model
      has_path_keys(:country, :region, :city, :street, :number)
    end

    ad = Address.new(country: 'Ukraine', region: 'Cherkasy', city: 'Cherkasy')
    expect(ad.id).to be
    expect(->{
      ad.path
    }).to raise_error(Fire::Model::PathValueMissingError)

    ad.id = 'my_id'
    ad.street = 'Some Street'
    ad.number = 101
    expect(ad.path).to eq('Address/ukraine/cherkasy/cherkasy/some-street/101/my_id')
  end

  context 'Persistence' do

    class Animal < Fire::Model
      has_path_keys(:kingdom, :phylum, :subphylum, :class, :order, :family)
    end

    let(:path_data) do
      {
          kingdom: 'Animalia',
          phylum: 'Chordata',
          subphylum: 'Vertebrata',
          class: 'Mammalia',
          order: 'Lagomorpha',
          family: 'Leporidae',
      }
    end

    it 'should query save object with path keys' do
      expect(Animal.all).to eq([])
      expect(Animal.take(path_data)).to be_nil

      rabbit = Animal.new(path_data.merge(name: 'Bunny', age: 2))
      rabbit.save

      loaded_rabbit = Animal.take(path_data)

      expect(loaded_rabbit).to be_a(Animal)
      expect(rabbit.age).to eq(2)
      expect(rabbit.name).to eq('Bunny')
      expect(rabbit.kingdom).to eq('Animalia')

      expect(Animal.all).to eq([ rabbit ])
    end

  end

end
