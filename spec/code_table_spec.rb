require 'csv'
require 'code_table'

describe CodeTable do 
	let(:player_name) {'Hector'}
	let(:score) {10}
	
	context 'Creating file if no exisitng' do 
		before do
			file_path = File.expand_path("~/.resources/players_data.csv")
			File.delete(file_path) if File.exists?(file_path)			
		end
		it 'makes sure a file is going to be created' do
			file_path = File.expand_path("~/.resources/players_data.csv")
			expect(File.exists?(file_path)).to be false
			CodeTable.prepare_file
			expect(File.exists?(file_path)).to be true
		end
	end


	context 'Writes the player name and the score to the csv file or creates the file' do 
		before do 
			CodeTable.prepare_file
			CodeTable.write_data(player_name,score)				
		end

		it 'writes Hector as the player and 10 as the score' do
			file = CSV.read(File.expand_path('~/.resources/players_data.csv'))
			last_row = file.last
			expect(last_row[0]).to eq('Hector')
			expect(last_row[1]).to eq('10')

		end
	end
end