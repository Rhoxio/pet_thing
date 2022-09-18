require 'stringio'
require 'awesome_print'
require 'colorize'

$energy_limits = {
  activity: 50,
  pet: 100,
  food: 50
}

$puts_mode = true
$rest_energy = 40
$eat_energy = 20
$interval = 2

Dir[File.join(__dir__, 'models', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'interfaces', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'modules', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'loggers', '*.rb')].each { |file| require file }