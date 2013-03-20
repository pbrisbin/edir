require 'edir/edit'
require 'edir/change'
require 'edir/listing'
require 'edir/version'

module Edir
  class Main
    include FileUtils

    def run(argv)
      options = parse_options(argv)

      before = `/usr/bin/ls -l -h -1 --inode`
      after  = Edit.new(before).run

      change = Change.new(before, after)
      change.options = options

      change.commit

    rescue => ex
      puts "Error: #{ex}", *ex.backtrace
      exit 1
    end

    private

    def parse_options(argv)
      {}.tap do |opts|
        while arg = argv.shift
          case arg
          when '-v', '--verbose' then opts[:verbose] = true
          when '-d', '--dry-run' then opts[:noop] = true
          end
        end
      end
    end

  end
end
