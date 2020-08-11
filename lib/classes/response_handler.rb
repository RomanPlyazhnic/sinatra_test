class ResponseHandler
  def initialize(result_entity:, controller:, positive_code: 200, negative_code: 400)
    @controller = controller
    @positive_code = positive_code
    @negative_code = negative_code
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

  def self.handle_exception(exception:, code: 400)
    status code
    body exception.message
  end

  private

  def positive_response
    @controller.status @positive_code
    @controller.body JSON(@result)
  end

  def negative_response
    @controller.status @negative_code
    @controller.body JSON(@errors)
  end
end