Common = Toruzou.module "Common"

class Common.Formatters

  @LOCAL_DATE_FORMAT = "YYYY/MM/DD"
  @LOCAL_DATETIME_FORMAT = "YYYY/MM/DD HH:mm:ss"

  @amount: (value) ->
    return "" unless value
    values = value.toString().split "."
    integral = values[0]
    integral = integral.replace /\B(?=(\d{3})+(?!\d))/g, ","
    decimal = if values[1] then ".#{values[1]}" else ""
    integral + decimal

  @percent: (value) ->
    return "" unless value
    "#{value} %"

  @localDate: (value) ->
    return "" unless value
    moment(value).format(@LOCAL_DATE_FORMAT)

  @localDatetime: (value) ->
    return "" unless value
    moment.utc(value).format(@LOCAL_DATETIME_FORMAT)
