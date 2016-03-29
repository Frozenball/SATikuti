require 'set'

example = "c
c start with comments
c
c
p cnf 5 3
1 -5 4 0
-1 5 3 4 0
-3 -4 0"

def parse_string(string)
  should_have_variables = nil
  should_have_clauses = nil
  used_variables = Set.new
  clauses = []
  string.split("\n").each do |line|
    if line.start_with? 'c'
      # comment, ignore
    elsif line.start_with? 'p'
      a, b, should_have_variables, should_have_clauses = line.split(' ')
      should_have_variables = should_have_variables.to_i
      should_have_clauses = should_have_clauses.to_i
    else
      variables = line.split ' '
      variables.pop
      variables.each do |var|
        used_variables.add var.to_i.abs
      end
      clauses.push variables.map(&:to_i)
    end
  end

  #raise 'Invalid number of variables' unless should_have_variables == used_variables.length
  raise 'Invalid number of clauses' unless should_have_clauses == clauses.length
  return {
    :clauses => clauses,
    :variables => used_variables
  }
end

def solve_sat(clauses, variables)

end
def try(clauses, variables)
  set_variables = Hash[(1...variables.size+1).zip variables]
  clauses.each do |clause|
    clause.each do |var|
      if var > 0
        if set_variables[var]
          break
        end
        return false
      else
        unless set_variables[-var]
          break
        end
        return false
      end
    end
  end
  return true
end


puts parse_string example
