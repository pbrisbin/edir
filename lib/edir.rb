require 'ext/fileutils'

require 'edir/edit'
require 'edir/listing'
require 'edir/version'

module Edir
  class Main
    include FileUtils

    def run
      before_str = `/usr/bin/ls -l -h -1 --inode`
      after_str  = Edit.new(before_str).run

      before = Listing.new(before_str)
      after  = Listing.new(after_str)

      before.each do |inode, names|
        original = names.first or next

        if after.missing?(inode)
          remove original
        end
      end

      after.each do |inode, names|
        original = before[inode].first or next

        next if names == [original] # no change

        if names.include?(original)
          names.delete(original)
          copy original, names
        else
          move original, names
        end
      end

    rescue => ex
      puts "Error: #{ex}", *ex.backtrace
      exit 1
    end

  end
end
