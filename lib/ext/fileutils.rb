require 'fileutils'

# Adds remove/copy/move for our purposes: default options,
# multi-destination copies, and move as copy-then-remove.
module FileUtils
  def remove(file)
    rm_r file, options
  end

  def copy(source, destinations)
    destinations.each do |name|
      cp_r source, name, options
    end
  end

  def move(source, destinations)
    copy source, destinations
    remove source
  end

  private

  def options
    { :verbose => true }
  end
end
