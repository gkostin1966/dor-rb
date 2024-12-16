class Store
  def update(entity)
    key = entity.identifier.to_s
    identifiers[key] = {} unless identifiers.key?(key)
  end

  def identifiers
    @identifiers ||= {}
  end
end
