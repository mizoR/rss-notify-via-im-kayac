# -*- coding: utf-8 -*-

class Entry < ActiveRecord::Base

  belongs_to :rss

  validates :url    , :presence => true, :uniqueness => true
  validates :title  , :presence => true
  validates :content, :presence => true

end
