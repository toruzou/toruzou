def body
  response.body
end

def status
  response.status
end

def assert_success
  expect(status).to eq(200)
end

def assert_not_fount
  expect(status).to eq(404)
end

def assert_unprocessable_entity
  expect(status).to eq(422)
end

def assert_total_entries(entries_count)
  expect(JSON.parse(body)[0]['total_entries']).to eq(entries_count)
end

def assert_contains_entry(*id)
  ids = Array.new

  JSON.parse(body)[1].each { |entry|
    ids.push(entry['id'])
  }

  id.each { |entry|
    assert ids.include?(entry), "Entry #" + entry.to_s + " is expected to rendered, but isn't."
  }
end
