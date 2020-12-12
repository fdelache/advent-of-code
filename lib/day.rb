# Helper for days
class Day
  def self.pad(day)
    day.to_i < 10 ? '0' + day : day
  end
end
