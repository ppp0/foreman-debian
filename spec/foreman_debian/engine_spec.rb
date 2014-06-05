require 'spec_helper'

describe ForemanDebian::Engine, :fakefs do

  let(:engine) { ForemanDebian::Engine.new('app') }

  it 'job concurrency detects if job should be enabled' do
    {
        {'all' => 1} => 1,
        {'all' => 0, 'foo' => 1} => 1,
        {'all' => 1, 'foo' => 0} => 0,
        {} => 0,
        {'bar' => 1} => 0,
    }.each do |concurrency, expected|
      expect(engine.job_concurrency(concurrency, 'foo')).to be == expected
    end
  end
end
