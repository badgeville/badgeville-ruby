require 'spec_helper'

describe 'Badgeville::VERSION' do
  it 'should be the correct version' do
    Badgeville::VERSION.should eql('1.0.0')
  end
end