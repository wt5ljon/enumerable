require_relative 'spec_helper.rb'

describe Enumerable do
	describe "#my_each works with an array" do
		it "returns each member of array" do
			new_array = []
			[2, 4, 6, 8, 10, 12].my_each { |num| new_array.push(num) }
			expect(new_array).to eq [2, 4, 6, 8, 10, 12]
		end
	end

	describe "#my_each works with a range" do
		it "returns each member of the range" do
			array = []
			('a'..'j').my_each { |item| array.push(item) }
			expect(array).to eq %w(a b c d e f g h i j)
		end
	end

	describe "#my_each_with_index works with an array" do
		it "returns each member and index of array" do
			array = [10, 20, 30, 40, 50, 60]
			array.my_each_with_index do |num, index|
				expect(num).to eq array[index]
			end
		end
	end

	describe "#my_each_with_index works with a range" do
		it "returns each member and index of a range" do
			char = 'a'
			index = 0
			('a'..'z').my_each_with_index do |item, i|
				expect(item).to eq char
				expect(i).to eq index
				char.next!
				index += 1
			end
		end
	end

	describe "#my_select works with an array" do
		it "returns an array of only even numbers" do
			array = [4, 3, 10, 11, 16, 18, 21, 23]
			new_array = array.my_select { |num| num % 2 == 0 }
			expect(new_array).to eq [4, 10, 16, 18]
		end
	end

	describe "#my_select works with a range" do
		it "returns an array of letters greater than'e' and less than 't'" do
			new_array = ('a'..'z').my_select { |item| item > 'e' && item < 't' }
			expect(new_array).to eq %w(f g h i j k l m n o p q r s)
		end
	end

	describe "#my_all with a text array" do
		it "return true if length of all members greater than 4" do
			array = %w(bears joint fallacy beautiful)
			expect(array.my_all? { |item| item.length > 4 }).to be true
		end

		it "return false if length of all members not less than or equal to 3" do
			array = %w(it jot fallacy out by)
			expect(array.my_all? { |item| item.length <= 3 }).to be false
		end
	end

	describe "#my_any with a text array" do
		it "return true if length of any members greater than 4" do
			array = %w(be jot fallacy beautiful)
			expect(array.my_any? { |item| item.length > 4 }).to be true
		end

		it "return false if length of any members not less than or equal to 3" do
			array = %w(talk joint fallacy outside byway)
			expect(array.my_any? { |item| item.length <= 3 }).to be false
		end
	end

end

