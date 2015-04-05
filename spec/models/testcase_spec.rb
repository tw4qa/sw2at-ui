require 'spec_helper'

describe TestCase do

  it 'have a collection' do
    expect(TestCase.collection).to eq('TestCase')
  end

  context 'Data & Firebase API' do

    before :each do
      clean_firebase!
      @namespace_1 = { branch: ?b, user: 'me', revision: DateTime.parse('21/03/1990 10:00') }
      @namespace_2 = { branch: ?r, user: 'yu', revision: DateTime.parse('21/03/1990 10:00') }
    end

    it 'should manage data' do
      expect(TestCase.all).to eq([])
      expect(Namespace.all).to eq([])

      Namespace.add(@namespace_1)
      Namespace.add(@namespace_2)
      expect(Namespace.all).to eq([@namespace_1, @namespace_2])

      TestCase.add_to_namespace(@namespace_1, { 'value' =>  1 })
      TestCase.add_to_namespace(@namespace_1, { 'value' =>  2 })
      TestCase.add_to_namespace(@namespace_1, { 'value' =>  3 })

      TestCase.add_to_namespace(@namespace_2, { 'value' =>  4 })
      TestCase.add_to_namespace(@namespace_2, { 'value' =>  5 })
      TestCase.add_to_namespace(@namespace_2, { 'value' =>  6 })

      expect(TestCase.all).to eq([
        { 'value' =>  1 }, { 'value' =>  2 }, { 'value' =>  3 },
        { 'value' =>  4 }, { 'value' =>  5 }, { 'value' =>  6 }
      ])
      expect(TestCase.all_in_namespace(Namespace.encrypt_namespace @namespace_1)).to eq([
        { 'value' =>  1 }, { 'value' =>  2 }, { 'value' =>  3 }
      ])
      expect(TestCase.all_in_namespace(Namespace.encrypt_namespace @namespace_2)).to eq([
        { 'value' =>  4 }, { 'value' =>  5 }, { 'value' =>  6 }
      ])

      Namespace.remove_branch(?r)
      expect(Namespace.all).to eq([@namespace_1])
      expect(TestCase.all).to eq([{ 'value' =>  1 }, { 'value' =>  2 }, { 'value' =>  3 }])
    end

  end
end