require "./dor/entity"

class Metadata < Entity
  def initialize(monograph:, identifier: Identifier.new)
    @monograph = monograph
    @identifier = identifier
  end

  def to_s
    "#{identifier} [ #{monograph} ]"
  end

  attr_reader :monograph
end
