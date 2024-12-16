class Bin
  def initialize(monograph)
    @monograph = monograph
    @scanned_pages = []
    @ocr = []
    @metadata = {}
  end

  attr_reader :monograph

  attr_reader :scanned_pages

  attr_reader :ocr

  attr_reader :metadata

  def identifier
    monograph.identifier
  end

  def to_s
    "{ id: #{identifier}, pages: #{scanned_pages.size}, ocr: #{ocr.size}, metadata: #{metadata} }"
  end
end
