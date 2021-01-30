# typed: strict
# frozen_string_literal: true

FORCE_BOTTLE = [
  'gettext', 'guntls',
  'ghc', 'ghc@8.8',
  'shellcheck', 'pandoc', 'ghostscript', 'graphviz'
]

IGNORE_BOTTLE = [
  'perl', 'ruby', 'vim', 'zsh', 'less', 'ncurses', 'bison', 'ninja', 'figlet',
  'openssl@1.1', 'git', 'ghostscript'
]

class BottleSpecification
  def skip_relocation?
    false
  end
  def compatible_cellar_with_name?(name)
    # return true if compatible_cellar?
    return true if compatible_locations?
    return false if IGNORE_BOTTLE.include? name
    true
  end
end

class SoftwareSpec
  def bottled?
    bottle_specification.tag?(Utils::Bottles.tag) && \
      (bottle_specification.compatible_cellar_with_name?(name) || owner.force_bottle)
  end
end


class Bottle
  def compatible_cellar?
    @spec.compatible_cellar_with_name?(name)
  end
end
