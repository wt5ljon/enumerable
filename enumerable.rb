#
module Enumerable

	def my_each
		i = 0
		while i < self.length
			yield(self[i])
			i += 1
		end
	end

	def my_each_with_index
		i = 0
		while i < self.length
			yield(self[i], i)
			i+= 1
		end
	end

	def my_select
		out = []
		self.my_each do |item|
			if yield(item)
				out.push(item)
			end
		end
		out
	end

	def my_all?
		out = true
		self.my_each do |item|
			if not yield(item)
				out = false
				break
			end
		end
		out
	end

	def my_any?
		out = false
		self.my_each do |item|
			if yield(item)
				out = true
				break
			end
		end
		out
	end

	def my_none?
		out = true
		self.my_each do |item|
			if yield(item)
				out = false
				break
			end
		end
		out
	end

	def my_count(*args)
		if args.length == 0
			if not block_given?
				return self.length
			else
				count = 0
				self.my_each do |item|
					if yield(item)
						count += 1
					end
				end
				return count
			end
		else
			out = self.my_select { |item| item == args[0].to_i }
			return out.length
		end
	end
end
