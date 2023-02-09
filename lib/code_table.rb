require 'csv'
class CodeTable 
  def self.write_data(player_name, score)
    CSV.open('resources/players_data.csv', 'a') do |csv|
      csv << [player_name, score.to_i]
    end
  end

  def self.prepare_file
    unless File.exists?('resources/players_data.csv')
      File.open('resources/players_data.csv', 'w') {|file| file.truncate(0)}
    end
  end
end
