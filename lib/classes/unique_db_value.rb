class UniqueDbValue
  MAXIMUM_ITERATIONS = 100

  def generate(model:, field:)
    iterator = 1

    loop do
      generated_field = yield
      found_rows_generated_field = model.where("#{field}": generated_field)
      
      if found_rows_generated_field.count > 0
        iterator += 1
        break if iterator > MAXIMUM_ITERATIONS
      else
        return generated_field
      end
    end
  end
end