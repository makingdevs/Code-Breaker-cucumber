require 'csv'
class CodeTable 
  def self.write_data(player_name, score)
    CSV.open('resources/players_data.csv', 'a') do |csv|
      csv << [player_name, score.to_i]
    end
  end

  def self.prepare_file
    directory = 'resources'
    file_path = File.join(directory, 'players_data.csv')

    unless File.directory?(directory)
      Dir.mkdir(directory)
    end

    unless File.exists?(file_path)
      File.open(file_path, 'w') {|file| file.truncate(0)}
    end
  end

end
