require 'spec_helper'

describe TestCase do

  before :each do
    Fire.drop!
    @params = { branch: 'b', time: '1990-03-21T10:00', user: 'me' }
  end

  it 'should have a colelction' do
    expect(TestCase.new.collection_name).to eq('TestCase')
  end

  context 'Creating' do

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

    before :all do
      @params = { branch: 'b', time: '1990-03-21T10:00', user: 'me' }
    end

    it 'should add an object' do
      t1 = TestCase.collect(
          { branch: 'b', time: '1990-03-21T10:00', user: 'me' },
          RSpecExampleMock.new(description: 'Great test', run_time: 3, status: :passed),
          thread_id: 1
      )
      t2 = TestCase.collect(
          { branch: 'b', time: '1990-03-21T09:00', user: 'me' },
          RSpecExampleMock.new(description: 'Perfect test', run_time: 2, status: :passed),
          thread_id: 1
      )
      t3 = TestCase.collect(
          { branch: 'c', time: '1990-03-21T09:00', user: 'yu' },
          RSpecExampleMock.new(description: 'Bad test', run_time: 10, status: :failed),
          thread_id: 2
      )
      
      expect(current_data).to eq(
        {'TestCase'=>
             {'b'=>
                  {'me'=>
                       {'1990-03-21t09-00'=>
                            {'1_'=>
                                 {t2.id=>
                                      {'branch'=>'b',
                                       'description'=>'Perfect test',
                                       'id'=>t2.id,
                                       'run_time'=>2,
                                       'status'=>'passed',
                                       'thread_id'=>1,
                                       'time'=>'1990-03-21T09:00',
                                       'user'=>'me'}}},
                        '1990-03-21t10-00'=>
                            {'1_'=>
                                 {t1.id=>
                                      {'branch'=>'b',
                                       'description'=>'Great test',
                                       'id'=>t1.id,
                                       'run_time'=>3,
                                       'status'=>'passed',
                                       'thread_id'=>1,
                                       'time'=>'1990-03-21T10:00',
                                       'user'=>'me'}}}}},
              'c'=>
                  {'yu'=>
                       {'1990-03-21t09-00'=>
                            {'2_'=>
                                 {t3.id=>
                                      {'branch'=>'c',
                                       'description'=>'Bad test',
                                       'id'=>t3.id,
                                       'run_time'=>10,
                                       'status'=>'failed',
                                       'thread_id'=>2,
                                       'time'=>'1990-03-21T09:00',
                                       'user'=>'yu'}}}}}}})
    end

  end


end