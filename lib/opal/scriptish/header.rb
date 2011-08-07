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

require 'yaml'

module Opal; module Scriptish

class Header < Hash
  def self.parse (text)
    return unless text

    length = text.lines.to_a.length

    Header.new(YAML.parse(text.lines.map {|line|
      line[2 .. -1]
    }.join).transform)
  end

  def initialize (data)
    merge! data
  end

  def to_js
    '// ==UserScript== ' + map {|name, value|
      if value.is_a?(Array)
        value.map {|value|
          "// @#{name}: #{value}"
        }.join("\n")
      else
        "// @#{name}: #{value}"
      end
    }.join("\n") + " // ==/UserScript==\n"
  end
end

end; end
