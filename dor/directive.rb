class Directive
  def initialize(preservation)
    @preservation = preservation
  end

  def submit_package_for_preservation(package)
    preservation.preserve(package)
  end

  attr_reader :preservation
end
