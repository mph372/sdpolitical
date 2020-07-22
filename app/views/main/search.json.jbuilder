json.people do
    json.array!(@people) do |person|
       json.name [person.last_name+', '+person.first_name]
       json.url person_path(person)
    end
end 