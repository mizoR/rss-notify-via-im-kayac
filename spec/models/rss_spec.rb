# -*- coding: utf-8 -*-
require 'spec_helper'

describe Rss do
  subject do
    described_class.new
  end

  it 'should respond to #entries' do
    should respond_to :entries
  end
end

