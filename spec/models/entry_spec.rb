# -*- coding: utf-8 -*-
require 'spec_helper'

describe Entry do
  subject do
    described_class.new
  end

  it 'should respond to #rss' do
    should respond_to :rss
  end
end

