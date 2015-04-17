json.array!(@events) do |event|
	json.extract! event, :id
	json.title Dog.find_by_id(event.dog_id).name
	json.description event.time_of_day
	json.start event.start_date
	json.end event.end_date
	json.color event.color
	json.url event_url(event, format: :json)
end