module Edir
  class Listing
    include Enumerable

    attr_reader :entries

    def initialize(items_str)
      items_str.lines do |line|
        words = line.strip.split(' ')

        if (name = words[9..-1])
          # when building the "after" manifest, there may be more than
          # one entry per inode to denote copies.
          entries[words[0]] << name.join(' ')
        end
      end
    end

    def [](inode)
      entries[inode]
    end

    def missing?(inode)
      !entries.has_key?(inode)
    end

    def each(&block)
      entries.each(&block)
    end

    private

    def entries
      @entries ||= Hash.new { |h,k| h[k] = [] }
    end
  end
end
