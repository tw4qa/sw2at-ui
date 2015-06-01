require 'spec_helper'

describe 'Revision Stats' do
  require 'ostruct'

  class RSpecExampleMock < OpenStruct; end

  before :each do
    clean_firebase!
    @namespace_1 = { branch: ?b, user: 'me', time: DateTime.parse('21/03/1990 10:00'), stats: nil }
    @namespace_2 = { branch: ?r, user: 'yu', time: DateTime.parse('21/03/1990 10:01'), stats: nil }

    expect(TestCase.all).to eq([])
    expect(Revision.all).to eq([])

    Revision.add(@namespace_1)
    Revision.add(@namespace_2)
    expect(Revision.all).to eq([@namespace_1, @namespace_2])
  end

  it 'should calculate stats' do
=begin
    expect(Revision.calculate_stats(@namespace_1)).to eq({
      runtime: 0,
      progress: :waiting,
      status: :undefined,
      items: {
          failed: 0,
          successful: 0,
      }
    })

    TestCase.collect(@namespace_1, 1, RSpecExampleMock.new(description: 'X', run_time: 1, exception: nil))
    TestCase.collect(@namespace_1, 1, RSpecExampleMock.new(description: 'Y', run_time: 2, exception: nil))
    TestCase.collect(@namespace_1, 1, RSpecExampleMock.new(description: 'Z', run_time: 4, exception: 'BadException'))
    TestCase.collect(@namespace_1, 1, RSpecExampleMock.new(description: 'O', run_time: 3, exception: nil))

    expect(Revision.test_cases(@namespace_1)).to eq([
      {"branch"=>"b", "description"=>"X", "run_time"=>1, "status"=>"success", "time"=>1, "user"=>"me"},
      {"branch"=>"b", "description"=>"Y", "run_time"=>2, "status"=>"success", "time"=>2, "user"=>"me"},
      {"branch"=>"b", "description"=>"Z", "run_time"=>4, "status"=>"failed", "time"=>4, "user"=>"me", 'exception' => 'BadException'},
      {"branch"=>"b", "description"=>"O", "run_time"=>3, "status"=>"success", "time"=>3, "user"=>"me"},
    ])
=end
  end

end
