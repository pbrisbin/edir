require 'fileutils'

module Edir
  class Change
    include FileUtils

    attr_accessor :options

    def initialize(before, after, options = {})
      @before = Listing.new(before)
      @after  = Listing.new(after)

      @options = {}
    end

    def commit
      before.each do |inode, names|
        from = names.first or next
        to   = after[inode]

        next if to == [from] # no change

        if to.empty?
          remove from
        elsif to.include?(from)
          copy from, to
        else
          move from, to
        end
      end
    end

    private

    attr_reader :before, :after

    def remove(file)
      rm_r file, options
    end

    def copy(from, to)
      to.delete(from)
      to.each { |t| cp_r from, t, options }
    end

    def move(from, to)
      copy from, to
      remove from
    end

  end
end
