class Catalog
  def update(entity)
    key = entity.identifier.to_s
    entries[key] = entity.monograph.identifier.to_s
  end

  def entries
    @entries ||= {}
  end
end
