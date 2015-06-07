require 'spec_helper'

describe 'Revision Stats' do
  require 'ostruct'

  class RSpecExampleMock < OpenStruct;

    def metadata
      {
          execution_result: OpenStruct.new({
            status: status,
            started_at: started_at,
            run_time: run_time,
          })
      }
    end
  end

  class RSpecThreadResultMock < OpenStruct; end


  before :each do
    clean_firebase!
    @namespace_1 = { branch: ?b, user: 'me', time: DateTime.parse('21/03/1990 10:00'), results: nil, threads: nil }
    @namespace_2 = { branch: ?r, user: 'yu', time: DateTime.parse('21/03/1990 10:01'), results: nil, threads: nil }

    expect(TestCase.all).to eq([])
    expect(Revision.all).to eq([])

    Revision.add(@namespace_1)
    Revision.add(@namespace_2)
    expect(Revision.all).to eq([@namespace_1, @namespace_2])
  end

  it 'should collect cases' do
    extras = {
        thread_id: 0
    }

    TestCase.collect(@namespace_1, RSpecExampleMock.new(description: 'X', run_time: 1, status: :passed), extras)
    TestCase.collect(@namespace_1, RSpecExampleMock.new(description: 'Y', run_time: 2, status: :passed, exception: nil), extras)
    TestCase.collect(@namespace_1, RSpecExampleMock.new(description: 'Z', run_time: 4, status: :failed, exception: 'BadException'), extras)
    TestCase.collect(@namespace_1, RSpecExampleMock.new(description: 'O', run_time: 3, status: :passed, exception: nil), extras)

    expect(Revision.test_cases(@namespace_1)).to eq([
      {"description"=>"X", "run_time"=>1, "status"=>"passed", "thread_id"=>0},
      {"description"=>"Y", "run_time"=>2, "status"=>"passed", "thread_id"=>0},
      {"description"=>"Z", "exception"=>"BadException", "run_time"=>4, "status"=>"failed", "thread_id"=>0},
      {"description"=>"O", "run_time"=>3, "status"=>"passed", "thread_id"=>0}
    ])
    expect(Revision.test_cases(@namespace_2)).to eq([])

    expect(Revision.all.first).to eq(@namespace_1)

    Revision.add_thread_results(@namespace_1,
      RSpecThreadResultMock.new(
        examples: [
            RSpecExampleMock.new(description: 'X', run_time: 1, status: :passed),
            RSpecExampleMock.new(description: 'y', run_time: 2, status: :failed)
        ],
        pending_examples: [],
        failed_examples: [ RSpecExampleMock.new(description: 'y', run_time: 2, status: :failed) ],
        fully_formatted_failed_examples: 'Errors.'
    ), extras)

    expect(Revision.all.first).to eq({
      :branch=> "b",
      :time=> DateTime.parse('21/03/1990 10:00'),
      :user=> "me",
      threads: nil,
      :results=>[ {"failed_examples"=>1, "formatted_fails"=>"Errors.", "thread_id"=>0, "pending_examples"=>0, "total_examples"=>2, "total_runtime"=>3} ]
    })
  end

end
