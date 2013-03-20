require 'tempfile'

module Edir
  class Edit
    def initialize(listing)
      @listing = listing
    end

    def run
      Tempfile.open('rw') do |tempfile|
        tempfile.puts(header)
        tempfile.puts(listing)
        tempfile.puts(footer)
        tempfile.flush

        system("$EDITOR '#{tempfile.path}'") or raise $?

        tempfile.rewind
        tempfile.read
      end
    end

    private

    attr_reader :listing

    def header
      <<EOF
#
# edir #{VERSION} by pbrisbin
#
###

$ ls '#{ENV['PWD']}'
EOF
    end

    def footer
      <<EOF

#
# Supported actions:
#
#  * Remove lines to mark them for deletion
#  * Change filenames to have those files moved
#  * Copy and change lines to copy those files
#
# The first column is the file's identifier, any lines which don't start
# with a pre-existing identifier are ignored.
#
# The ls output is for convenience only, changes which modify the
# overall number of fields between the identifer and the filename could
# result that line being ignore, or making an unintended change.
#
EOF
    end

  end
end
