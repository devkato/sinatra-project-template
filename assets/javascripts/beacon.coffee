# root = exports ? this

window.console.log = console.log || () -> return

obj_name = window['AnalyticsObject']

# --------------------------------------------------------------------------------
# beaconを飛ばすためにimgタグを作成する
# --------------------------------------------------------------------------------
renderImg = (src) ->
  # console.log 'renderImg called'
  img = document.createElement('img')
  img.width = 1
  img.height = 1
  img.src = src
  document.body.appendChild img

# --------------------------------------------------------------------------------
# q（Arrayオブジェクト）のpush関数に対して、イベントデータをpushした瞬間にpopして
# beaconを送信するように拡張する
#
# [argumentsの中身]
#   event_name イベントの識別子
#   data イベントに紐づけて送信するデータ。{}的なobjectの形を取る。
# --------------------------------------------------------------------------------
window[obj_name].q.push = (args) ->
  # console.log '--------------------------------------------------------------------------------'
  # console.log 'q.push is called'
  Array.prototype.push.call(this, args)
  window[obj_name].pop()

# --------------------------------------------------------------------------------
# queue(q)にたまったデータを取得して、beacon用の画像を出力する
# --------------------------------------------------------------------------------
window[obj_name].pop = () ->
  # console.log '--------------------------------------------------------------------------------'
  # console.log 'pop is called'
  res = window[obj_name].q.shift()

  event_name = res[0]
  # console.log event_name
  # console.log "event_name -> #{event_name}"

  data = res[1] || {}
  # console.log data

  console.log '--------------------------------------------------------------------------------'
  console.log "event_name -> #{event_name}"
  console.log data

  # 画像のURLを生成
  url = [
    '//localhost:9292/api/web/v1/beacon',
    "?e=#{event_name}",
    "&d=#{encodeURIComponent(JSON.stringify(data))}"
  ].join('')

  renderImg url

# 既に登録されているイベントがqueueにたまっている場合は、
# そちらを先に処理する
while window[obj_name].q.length > 0
  window[obj_name].pop()
