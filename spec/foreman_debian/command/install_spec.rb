require 'spec_helper'

describe ForemanDebian::Command::Install, :fakefs do

  it 'concurrency enables jobs' do
    command = ForemanDebian::Command::Install.new('/foo')
    {
        'all=1' => {'all' => 1},
        'foo=1,bar=2' => {'foo' => 1, 'bar' => 2},
        'bar==2' => :exception,
    }.each do |encoded, decoded|
      result = command.decode_concurrency(encoded) rescue :exception
      expect(result).to be == decoded
    end
  end
end
