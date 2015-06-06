require 'spec_helper'

describe TestCase do

  it 'have a collection' do
    expect(TestCase.collection).to eq('TestCase')
  end

  context 'Data & Firebase API' do

    before :each do
      clean_firebase!
      @namespace_1 = { branch: ?b, user: 'me', time: DateTime.parse('21/03/1990 10:00'), results: nil, threads: nil }
      @namespace_2 = { branch: ?r, user: 'yu', time: DateTime.parse('21/03/1990 10:01'), results: nil, threads: nil }

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
    end

    context 'Data management' do

      it 'should query revisions with tests' do
         expect(Revision.query_one(@namespace_1)).to eq({
              "main"=>
               {"branch"=>"b",
                "id"=>"b:::03-21-1990_10-00:::me",
                "time"=>"1990-03-21T10:00:00.000+00:00",
                "user"=>"me"},
           :tests=>[{"value"=>1}, {"value"=>2}, {"value"=>3}]}
         )
      end

      it 'should query correctly' do
        expect(TestCase.all).to eq([
           { 'value' =>  1 }, { 'value' =>  2 }, { 'value' =>  3 },
           { 'value' =>  4 }, { 'value' =>  5 }, { 'value' =>  6 }
        ])

        expect(TestCase.all_in_namespace(@namespace_1)).to eq([
            { 'value' =>  1 }, { 'value' =>  2 }, { 'value' =>  3 }
        ])
        expect(TestCase.all_in_namespace(@namespace_2)).to eq([
            { 'value' =>  4 }, { 'value' =>  5 }, { 'value' =>  6 }
        ])

        expect(Revision.test_cases(@namespace_1)).to eq([
            { 'value' =>  1 }, { 'value' =>  2 }, { 'value' =>  3 }
        ])
        expect(Revision.test_cases(@namespace_2)).to eq([
            { 'value' =>  4 }, { 'value' =>  5 }, { 'value' =>  6 }
        ])

        # Single Options

        expect(TestCase.query({})).to eq([
           { 'value' =>  1 }, { 'value' =>  2 }, { 'value' =>  3 },
           { 'value' =>  4 }, { 'value' =>  5 }, { 'value' =>  6 }
        ])

        expect(TestCase.query( time: DateTime.parse('21/03/1990 10:00') )).to eq([
           { 'value' =>  1 }, { 'value' =>  2 }, { 'value' =>  3 },
        ])

        expect(TestCase.query( time: DateTime.parse('21/03/1990 10:01') )).to eq([
           { 'value' =>  4 }, { 'value' =>  5 }, { 'value' =>  6 }
        ])

        expect(TestCase.query( user: 'me' )).to eq([
           { 'value' =>  1 }, { 'value' =>  2 }, { 'value' =>  3 },
        ])

        expect(TestCase.query( branch: ?b )).to eq([
             { 'value' =>  1 }, { 'value' =>  2 }, { 'value' =>  3 },
        ])

        expect(TestCase.query( user: 'yu' )).to eq([
           { 'value' =>  4 }, { 'value' =>  5 }, { 'value' =>  6 }
        ])

        expect(TestCase.query( branch: ?r )).to eq([
           { 'value' =>  4 }, { 'value' =>  5 }, { 'value' =>  6 }
        ])

        # Array options

        expect(TestCase.query( branch: [ ?r, ?b ], time: []) ).to eq([
             { 'value' =>  1 }, { 'value' =>  2 }, { 'value' =>  3 },
             { 'value' =>  4 }, { 'value' =>  5 }, { 'value' =>  6 }
        ])

        expect(TestCase.query( user: [ 'yu', 'me' ])).to eq([
            { 'value' =>  1 }, { 'value' =>  2 }, { 'value' =>  3 },
            { 'value' =>  4 }, { 'value' =>  5 }, { 'value' =>  6 }
        ])

        expect(TestCase.query( user: [ 'me' ] )).to eq([
           { 'value' =>  1 }, { 'value' =>  2 }, { 'value' =>  3 },
        ])

        expect(TestCase.query( branch: [ ?b ], time: [] )).to eq([
           { 'value' =>  1 }, { 'value' =>  2 }, { 'value' =>  3 },
        ])

        expect(TestCase.query( user: [ 'yu' ] )).to eq([
             { 'value' =>  4 }, { 'value' =>  5 }, { 'value' =>  6 }
        ])

        expect(TestCase.query( branch: [ ?r ] )).to eq([
          { 'value' =>  4 }, { 'value' =>  5 }, { 'value' =>  6 }
        ])

        expect(TestCase.query( time: [ DateTime.parse('21/03/1990 10:00'), DateTime.parse('21/03/1990 10:01') ] )).to eq([
             { 'value' =>  1 }, { 'value' =>  2 }, { 'value' =>  3 },
             { 'value' =>  4 }, { 'value' =>  5 }, { 'value' =>  6 }
        ])


        expect(TestCase.query( user: [ 'me' ],  branch: [ ?b ] )).to eq([
             { 'value' =>  1 }, { 'value' =>  2 }, { 'value' =>  3 },
        ])

        expect(TestCase.query( user: [ 'me' ],  branch: [ ?b, ?r ] )).to eq([
            { 'value' =>  1 }, { 'value' =>  2 }, { 'value' =>  3 },
        ])

        expect(TestCase.query( user: [ 'me' ],  branch: [ ?r ] )).to eq([])
      end

      it 'should delete branches' do
        Revision.remove_branch(?r)
        expect(Revision.all).to eq([@namespace_1])
        expect(TestCase.all).to eq([{ 'value' =>  1 }, { 'value' =>  2 }, { 'value' =>  3 }])
      end

      it 'should delete users' do
        Revision.remove_user('yu')
        expect(Revision.all).to eq([@namespace_1])
        expect(TestCase.all).to eq([{ 'value' =>  1 }, { 'value' =>  2 }, { 'value' =>  3 }])
      end

      it 'should delete times' do
        Revision.remove_by_time('21/03/1990 10:00')
        Revision.remove_by_time('21/03/1990 10:01')
        expect(Revision.all).to eq([])
        expect(TestCase.all).to eq([])
      end

      it 'should delete branches' do
        Revision.remove_branch(?b)
        expect(Revision.all).to eq([@namespace_2])
        expect(TestCase.all).to eq([{ 'value' =>  4 }, { 'value' =>  5 }, { 'value' =>  6 }])
      end

    end


  end
end