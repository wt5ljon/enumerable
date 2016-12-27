#
module Enumerable

	def my_each
		i = 0
		while i < self.size
			if self.is_a?(Range)
				yield(self.to_a[i])
			else
				yield(self[i])
			end
			i += 1
		end
		self
	end

	def my_each_with_index
		i = 0
		while i < self.size
			if self.is_a?(Range)
				yield(self.to_a[i], i)
			else
				yield(self[i], i)
			end
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
		if args.size == 0
			if not block_given?
				return self.size
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

	def my_map
		out = []
		self.my_each { |item| out.push(yield(item)) }
		out
	end

	def my_inject(*args)
		accumulator = 0
		if block_given?
			if args.size > 0
				accumulator = args[0]
			else
				accumulator = self.first
			end
			self.my_each do |item|
				accumulator = yield(accumulator, item)
			end		
		end
		accumulator
	end

end
