require 'csv'
require 'code_table'

describe CodeTable do 
	let(:player_name) {'Hector'}
	let(:score) {10}
	
	context 'Creating file if no exisitng' do 
		before do  
			File.delete('resources/players_data.csv') if File.exists?('resources/players_data.csv')			
		end
		it 'makes sure a file is going to be created' do 
			expect(File.exists?('resources/players_data.csv')).to be false
			CodeTable.prepare_file
			expect(File.exists?('resources/players_data.csv')).to be true
		end
	end


	context 'Writes the player name and the score to the csv file or creates the file' do 
		before do 
			CodeTable.prepare_file
			CodeTable.write_data(player_name,score)				
		end

		it 'writes Hector as the player and 10 as the score' do
			file = CSV.read('resources/players_data.csv')
			last_row = file.last
			expect(last_row[0]).to eq('Hector')
			expect(last_row[1]).to eq('10')

		end
	end
end