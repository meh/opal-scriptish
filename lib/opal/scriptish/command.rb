#--
# Copyleft meh. [http://meh.paranoid.pk | meh@paranoici.org]
#
# This file is part of opal-scriptish.
#
# opal-scriptish is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# opal-scriptish is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with opal-scriptish. If not, see <http://www.gnu.org/licenses/>.
#++

require 'opal'
require 'opal/command'
require 'opal/scriptish/header'
require 'tempfile'
require 'pathname'

module Opal

class Command < Thor
  desc 'build [MAIN]', 'Build a Scriptish script ready for deploy'
  method_options :out => :string
  def build (file)
    content = File.read(file)
    header  = content.match(/\A# ---$(.*?)^# ---$/m).to_a.last

    unless file.end_with?('.rb') && header
      raise ArgumentError, "#{file} isn't a Scriptish script (header is missing)"
    end

    Dir.mkdir(dir = Tempfile.new('scriptish').tap {|f|
      break (path = f.path; f.unlink; path)
    })

    input = File.basename(file)

    File.open("#{dir}/#{input}", 'w') {|f|
      f.write %{require 'opal/scriptish';}
      f.write content
    }

    File.open(options[:out] || file.sub(/\.rb$/, '.user.js'), 'w') {|f|
      f.write header = Scriptish::Header.parse(header).tap {|h|
        (h['require'] = [h['require']]).unshift(
          'http://adambeynon.github.com/opal/js/opal.js',
          'http://adambeynon.github.com/opal/js/opal-parser.js').compact!
      }.to_js


      $:.unshift(Pathname.new(file).realpath.dirname)

      f.write Dir.chdir(dir) {
        builder = Builder.new
        builder.build :files => input, :out => 'output'

        $:.shift

        File.read('output')
      }
    }
  end
end

end
