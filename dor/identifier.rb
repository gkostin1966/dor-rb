require "securerandom"

class Identifier
  include Comparable

  def <=>(other)
    uuid <=> other.uuid
  end

  def initialize(uuid: SecureRandom.uuid)
    @uuid = uuid
  end

  attr_reader :uuid

  def to_s
    uuid
  end
end
