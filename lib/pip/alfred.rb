# coding: utf-8

module Pip
  module Alfred
    def self.bundle_id
      @@bundle_id
    end

    def self.bundle_id=(value)
      @@bundle_id = value
    end
  end
end