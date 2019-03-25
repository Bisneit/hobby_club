

class Events::CreateValidator
  def initialize(params)
    self.params = params
    self.result = false
  end

  def call
    check_main_params
    repeatable_events_params if need_validate_repeatable_params?
    result
  end

  private

  attr_accessor :result, :params

  def need_validate_repeatable_params?
    params[:type] != 'no'
  end

  def check_main_params
    test_event =  Event.new
    test_event.assign_attributes(event_params)
    self.result = test_event.valid? ? 'success' : test_event.errors.messages.first.last.first
  end

  def repeatable_events_params
    return if result != 'success'
    self.result = 'success'
    if params[:days]&.reject { |c| c.empty? }.blank?
      self.result = 'Выберите дни недели'
    end
    if params[:repeat_number].blank?
      self.result = 'Введите количество повторений'
    end
  end

  def event_params
    params.slice(:description, :date, :start_at, :end_at, :group_id)
  end

  def repeat_params
    params.slice(:type, :repeat_number, :without_weekends, :days)
  end
end
