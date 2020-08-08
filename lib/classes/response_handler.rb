class ResponseHandler
  def initialize(result_entity, controller)
    @controller = controller
    @result_entity = result_entity
    @errors = @result_entity.errors if (@result_entity && @result_entity.errors)
    @result = @result_entity.result if (@result_entity && @result_entity.result)
  end

  def response
    if @errors.nil? || @errors.empty?
      @controller.status 200
      @controller.body JSON(@result)
    else
      @controller.status 422
      @controller.body JSON(@errors)
    end
  end
end