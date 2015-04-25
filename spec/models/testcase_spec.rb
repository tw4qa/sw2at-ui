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
      expect(Revision.all).to eq([])

      Revision.add(@namespace_1)
      Revision.add(@namespace_2)
      expect(Revision.all).to eq([@namespace_1, @namespace_2])

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
      expect(TestCase.all_in_namespace(Revision.encrypt_namespace @namespace_1)).to eq([
        { 'value' =>  1 }, { 'value' =>  2 }, { 'value' =>  3 }
      ])
      expect(TestCase.all_in_namespace(Revision.encrypt_namespace @namespace_2)).to eq([
        { 'value' =>  4 }, { 'value' =>  5 }, { 'value' =>  6 }
      ])

      Revision.remove_branch(?r)
      expect(Revision.all).to eq([@namespace_1])
      expect(TestCase.all).to eq([{ 'value' =>  1 }, { 'value' =>  2 }, { 'value' =>  3 }])
    end

  end
end