# -*- coding: utf-8 -*-

class Rss < ActiveRecord::Base

  has_many :entries, :dependent => :nullify

  validates :title, :presence => true, :uniqueness => true
  validates :url  , :presence => true, :uniqueness => true

end
