#
module Enumerable

	# my implementation of #each
	def my_each
		i = 0
		while i < self.to_a.size
			if self.is_a?(Range)
				yield(self.to_a[i])
			else
				yield(self[i])
			end
			i += 1
		end
		self
	end

	# my implementation of #each_with_index
	def my_each_with_index
		i = 0
		while i < self.to_a.size
			if self.is_a?(Range)
				yield(self.to_a[i], i)
			else
				yield(self[i], i)
			end
			i+= 1
		end
	end

	# my implementation of #select
	def my_select
		out = []
		self.my_each do |item|
			if yield(item)
				out.push(item)
			end
		end
		out
	end

	# my implementation of #all?
	def my_all?
		out = true
		if block_given?
			self.my_each do |item|
				if not yield(item)
					out = false
					break
				end
			end
		else
			self.my_each do |item|
				if item == false or item == nil
					out = false
					break
				end
			end
		end
		out
	end

	# my implementation of #any?
	def my_any?
		out = false
		if block_given?
			self.my_each do |item|
				if yield(item)
					out = true
					break
				end
			end
		else
			self.my_each do |item|
				if item != false and item != nil
					out = true
					break
				end
			end
		end
		out
	end

	# my implementation of #none?
	def my_none?
		out = true
		if block_given?
			self.my_each do |item|
				if yield(item)
					out = false
					break
				end
			end
		else
			self.my_each do |item|
				if item != nil and item != false
					out = false
					break
				end
			end
		end
		out
	end

	# my implementation of #count
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

	# my implementation of #map
	def my_map(*args)
		out = []
		if args.size == 0
			self.my_each { |item| out.push(yield(item)) }
		else
			self.my_each { |item| out.push(args[0].call(item)) }
		end
		out
	end

	# my implementation of #inject
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

def multiply_els(array)
	answer = array.my_inject(1) { |product, item| product * item }
end

#my_proc = Proc.new { |i| i*5 }

#print "\n"

# test my_each
#[10,20,30,40,50].my_each { |i| print "#{i} " }
#print "\n"
#(1..10).my_each { |i| print "#{i} " }
#print "\n\n"

# test my_each_with_index
#[10,20,30,40,50].my_each_with_index { |item, i| puts "#{i}. #{item}" }
#print "\n"
#(1..10).my_each_with_index { |item, i| puts "#{i}. #{item}" }
#print "\n\n"

# test my_select
#out = (1..10).my_select { |i| i % 3 == 0 }
#print out
#print "\n"
#out = [1,2,3,4,5].my_select { |num| num.even? }
#print out
#print "\n\n"

# test my_all?
#puts ["ant", "bear", "cat"].my_all? { |word| word.length >= 3 }
#puts ["ant", "bear", "cat"].my_all? { |word| word.length >= 4 }
#puts [nil, true, 99].my_all?
#print "\n\n"

# test my_any?
#puts ["ant", "bear", "cat"].my_any? { |word| word.length >= 3 }
#puts ["ant", "bear", "cat"].my_any? { |word| word.length >= 4 }
#puts [nil, true, 99].my_any?
#print "\n\n"

# test my_none?
#puts ["ant", "bear", "cat"].my_none? { |word| word.length == 5 }
#puts ["ant", "bear", "cat"].my_none? { |word| word.length >= 4 }
#puts [].my_none?
#puts [nil].my_none?
#puts [nil, false].my_none?
#puts [nil, false, true].my_none?
#print "\n\n"

# test my_count
#ary = [1, 2, 4, 2]
#puts ary.my_count
#puts ary.my_count(2)
#puts ary.my_count { |x| x % 2 == 0 }
#print "\n\n"

# test #my_inject using #multiply_els
#print multiply_els([2, 4, 5])
#print "\n\n"

# test my_map
#print (1..4).my_map { |i| i*i }
#print "\n"
#print (1..4).my_map { "cat" }
#print "\n\n"

# test #my_map using a proc
#print (11..14).my_map(my_proc)
#print "\n"

# test #my_map using both proc and block
#print (1..5).my_map(my_proc) { |i| i**3 }
#print "\n\n"

