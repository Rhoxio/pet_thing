module Validator
  def self.validate_name_length(string)
    raise ArgumentError.new("Food name must be longer than two (2) characters.") if string.length < 2
    return true
  end

  def self.validate_energy_limit(model, energy)
    model_name = model.class.name.downcase.to_sym
    invalid = !Array(0..$energy_limits[model_name]).include?(energy)
    raise ArgumentError.new("Energy levels must be between 0 and 50.") if invalid
    return true
  end
end