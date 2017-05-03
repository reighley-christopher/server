explanatory_variable :sum do
  type :numeric
  input Object
  description "test of the explanatory variable, adds features x and y"
  calculate do |ob|
    next ob["x"] + ob["y"] 
  end
end
