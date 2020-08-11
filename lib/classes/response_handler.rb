class ResponseHandler
  def initialize(result_entity, controller)
    @controller = controller
    @errors = result_entity.errors if (result_entity && result_entity.errors)
    @result = result_entity.result if (result_entity && result_entity.result)
  end

  def response
    if @errors.nil? || @errors.empty?
      positive_response
    else
      negative_response
    end
  end

  private

  def positive_response
    @controller.status 200
    @controller.body JSON(@result)
  end

  def negative_response
    @controller.status 422
    @controller.body JSON(@errors)
  end
end