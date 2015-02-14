class notification 
  constructor : (title, time, category, description, id, ongoing) ->
    @title = title
    @time = time
    @category = category
    @description = description
    @id = id
    @ongoing = ongoing 
  constructor : (title, category, description, ongoing) ->
    @title = title
    @time
    @category = category
    @description = description
    @id = id
    @ongoing
  setTitle (title) ->
    @title = title
  getTitle ->
    return @title
  setTime (time) ->
    @time = time
  getTitle ->
    return @time
  setCategory (category) ->
    @category = category
  getCategory ->
    return @category
  setDescription (description) ->
    @description = description
  getDescription ->
    return @description
  setID (id) ->
    @id = id
  getID ->
    return @id
  setOngoing (ongoing) ->
    @ongoing = ongoing
  getOngoing ->
    return @ongoing